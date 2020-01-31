#! /bin/bash
set -e

#prelim mapping followed by minion pipeline for set of barcodes

runname=$1
pathToFastq=$2
ref=$3
files=${pathToFastq}/${runname}_all-*.fastq
echo $files

echo -e "sample\ttime\treads\tmapped\tbasesCovered\tbasesCoveredx20\tbasesCoveredx100" > $runname"_nb_mappingstats".txt

for f in $files
do
#start=`date +%s`
#iterate through each demultplexed fastq (i.e. find all fastq files with NB in name)
nb=$(echo "$f" | sed 's/.*\(NB[0-9][0-9]\).*/\1/')

#setup output files (newscheme and prelim already made in prelim script but need to set up as variables here)
newscheme=$(echo ~/pipeline_output/primer-schemes/$runname"_prelim"/$nb)
prelim=$(echo ~/pipeline_output/$runname/prelim/mapped/$nb)
#initial mapping and primer trim
mkdir -p ~/pipeline_output/$runname/initial_mapTrim/$nb
trim=$(echo ~/pipeline_output/$runname/initial_mapTrim/$nb)

#run preliminary mapping step to produce new reference scheme
~/Github/artic-rabv/other-scripts/rabies_prelimMap.sh $ref $pathToFastq $runname $nb

#produce bam file for primer trimming step
minimap2 -ax map-ont $newscheme/$runname"_prelim".reference.fasta $f | samtools view -u -| samtools sort - -T temp -o $trim/$runname"_"$nb".sorted.bam"
#primer trimming
align_trim  --normalise 200 ~/Github/artic-rabv/primer-schemes/$ref/V1/$ref.scheme.bed --report $trim/$runname"_"$nb".sorted".alignreport.txt < $trim/$runname"_"$nb".sorted.bam" 2> $trim/$nb".sorted".alignreport.er | samtools view -bS - | samtools sort -T %s - -o $trim/$runname"_"$nb".primertrimmed.sorted.bam"
samtools index $trim/$runname"_"$nb".primertrimmed.sorted.bam"
align_trim  ~/Github/artic-rabv/primer-schemes/$ref/V1/$ref.scheme.bed --report $trim/$runname"_"$nb".sorted".alignreport.txt < $trim/$runname"_"$nb".sorted.bam" 2> $trim/$nb".sorted".alignreport.er | samtools view -bS - | samtools sort -T %s - -o $trim/$runname"_"$nb".primertrimmed.nonorm.sorted.bam"
samtools index $trim/$runname"_"$nb".primertrimmed.nonorm.sorted.bam"

#produce trimmed fastq files
python ~/Github/realtime-rabies/rampart/pipelines/process_sample/rules/trim_primers.py --reads $f  --output_reads $trim/$runname.clipped.fastq

#summary mapping stats
reads=$(samtools view $trim/$runname"_"$nb".sorted.bam" | cut -f 1 | sort | uniq | wc -l)
mapped=$(samtools view -F 4 $trim/$runname"_"$nb".sorted.bam" | cut -f 1 | sort | uniq | wc -l)
basesCovered=$(samtools depth $trim/$runname"_"$nb".primertrimmed.sorted.bam" | awk '($3>0)' |wc -l)
basesCoveredx20=$(samtools depth $trim/$runname"_"$nb".primertrimmed.sorted.bam" | awk '($3>=20)' |wc -l)
basesCoveredx100=$(samtools depth $trim/$runname"_"$nb".primertrimmed.sorted.bam" | awk '($3>=100)' |wc -l)
echo -e $runname"_"${nb}"\t"$runtime"\t"$reads"\t"$mapped"\t"$basesCovered"\t"$basesCoveredx20"\t"$basesCoveredx100 >>$runname"_nb_mappingstats".txt

  done
mv $runname"_nb_mappingstats".txt $trim/.
