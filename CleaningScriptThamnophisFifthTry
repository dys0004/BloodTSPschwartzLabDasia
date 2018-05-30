#/bin/sh

#-- Auburn University High Performance and Parallel Computing
#-- Hopper Cluster Sample Job Submission Script

#-- This script provides the basic scheduler directives you
#-- can use to submit a job to the Hopper scheduler.
#-- Other than the last two lines it can be used as-is to
#-- send a single node job to the cluster. Normally, you
#-- will want to modify the #PBS directives below to reflect
#-- your workflow...

####-- For convenience, give your job a name

#PBS -N CleaningScriptThamnophisFifthTry

#-- Provide an estimated wall time in which to run your job
#-- The format is DD:HH:MM:SS.

#PBS -l walltime=03:00:00:00

#-- Indicate if\when you want to receive email about your job
#-- The directive below sends email if the job is (a) aborted,
#-- when it (b) begins, and when it (e) ends

#PBS -m abe dys0004@tigermail.auburn.edu

#-- Inidicate the working directory path to be used for the job.
#-- If the -d option is not specified, the default working directory
#-- is the home directory. Here, we set the working directory
#-- current directory

#PBS -d /scratch/ReptileTrinityDYS/Thamnophis

#-- We recommend passing your environment variables down to the
#-- compute nodes with -V, but this is optional

#PBS -V

#-- Specify the number of nodes and cores you want to use
#-- Hopper's standard compute nodes have a total of 20 cores each
#-- so, to use all the processors on a single machine, set your
#-- ppn (processors per node) to 20.

#PBS -l nodes=1:ppn=20

#-- Now issue the commands that you want to run on the compute nodes.

#-- With the -V option, you can load any software modules
#-- either before submitting, or in the job submission script.

#-- You should modify the lines below to reflect your own
#-- workflow...

#module load <myprogram_modulefile>
module load fastqc/11.5
module load trimmomatic/0.37
#module load samtools/1.3.1
#module load gcc/5.1.0
#module load bowtie2/2.2.9
#module load tophat/2.1.1
#module bcftools/1.3.1
#module load hisat/2.0.5
#module load stringtie/1.3.2d
#module load trinotate/3.0.2
#module load sqlite/3190300
#module load ncbi-blast/2.6.0
#module load hmmer/3.0
#module load pfamscan/9592
#module load transdecoder/3.0.1
#module load signalp-4.1/signalp
#module load signalp/4.1/signalp
#module load signalp/4.1
#module load tmhmm/2.0c
#module load rnammer/1.2
#module load hmmer/3.1b2
#module load perl/5.26.0

#./myprogram <parameters>

#--  After saving this script, you can submit your job to the queue
#--  with...

#--  qsub sample_job.sh
##########################################

#PBS -j oe
#PBS -q debug

# Define DATADIR to be where the input files are
DATADIR=/scratch/ReptileTrinityDYS/Thamnophis

#  Set the stack size to unlimited
ulimit -s unlimited

# Turn echo on so all commands are echoed in the output log

set -x
#


###################################################
#########Beginning of Trimommatic Script###########
###################################################

# Trimmomatic produces four files!!!!!!!!!!!!!!!!

# Paired forward fastq file
# Unpaired forward fastq file
# Paired reverse fastq file
# Unpaired reverse fastq file

## to go to the next step you need to use the paired filed 

# the file ID or individual
tissueID="Thamnophis_AAGAGA"

### Move to Scratch directory so all data processing happens here.
cd DATADIR

###  Unzip the data
gunzip ${tissueID}*.fastq.gz

###  Clean the data ####

############  Original File ######
### FastQC: run on the original file
#fastqc  ${tissueID}.fastq

#### Concatinate Forward Read (R1)files
# Colub_AATCCG_L001_R1_001.fastq
cat ${tissueID}_L001_R1_001.fastq ${tissueID}_L002_R1_001.fastq > ${tissueID}_All_R1.fastq

#### Concatenate Reverse Reads (R2) files
cat ${tissueID}_L001_R2_001.fastq ${tissueID}_L002_R2_001.fastq > ${tissueID}_All_R2.fastq

## Make sure you have an updated version of trimmomatic for the command below 
######## Trimmomatic
############  Trim read for quality when quality drops below Q30 and
#remove sequences shorter than 30 bp
#MINL6

java -jar /tools/trimmomatic-0.37/bin/trimmomatic.jar PE -phred33 ${tissueID}_All_R1.fastq ${tissueID}_All_R2.fastq ${tissueID}_All_R1_paired.fastq ${tissueID}_All_R1_unpaired.fastq ${tissueID}_All_R2_paired.fastq ${tissueID}_All_R2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 HEADCROP:10 LEADING:30 TRAILING:30 SLIDINGWINDOW:6:30 MINLEN:36


############  FastQC ##########
#(EXAMPLE OF ONE FILE) fastqc ${tissueID}_All_R1_paired.fastq

#### Files that we needed 
cp ${tissueID}_All_R1_paired.fastq /home/dys0004/ReptileBloodTranscriptome/Thamnophis/${tissueID}_All_R1_paired.fastq 
cp ${tissueID}_All_R2_paired.fastq /home/dys0004/ReptileBloodTranscriptome/Thamnophis/${tissueID}_All_R2_paired.fastq 


#### The rest of the files
#zip the files we need
gzip /home/dys0004/ReptileBloodTranscriptome/Thamnophis/*_paired.fastq





