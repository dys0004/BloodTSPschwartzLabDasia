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

#PBS -N Trinity.test15Thamnophis

#-- Provide an estimated wall time in which to run your job
#-- The format is DD:HH:MM:SS.

#PBS -l walltime=07:00:00:00

#-- Indicate if\when you want to receive email about your job
#-- The directive below sends email if the job is (a) aborted,
#-- when it (b) begins, and when it (e) ends

#PBS -m abe dys0004@tigermail.auburn.edu

#-- Inidicate the working directory path to be used for the job.
#-- If the -d option is not specified, the default working directory
#-- is the home directory. Here, we set the working directory
#-- current directory

#PBS -d /home/dys0004/ReptileBloodTranscriptome/Thamnophis

#-- We recommend passing your environment variables down to the
#-- compute nodes with -V, but this is optional

#PBS -V

#-- Specify the number of nodes and cores you want to use
#-- Hopper's standard compute nodes have a total of 20 cores each
#-- so, to use all the processors on a single machine, set your
#-- ppn (processors per node) to 20.

PBS -l nodes=1:ppn=20

#-- Now issue the commands that you want to run on the compute nodes.

#-- With the -V option, you can load any software modules
#-- either before submitting, or in the job submission script.

#-- You should modify the lines below to reflect your own
#-- workflow...

#module load <myprogram_modulefile>
#module load trinity/r2014-04-13p1
module load trinity/2.2.0
module load samtools/1.3.1
module load gcc/5.1.0

module load bowtie/0.12.8


#./myprogram <parameters>

#--  After saving this script, you can submit your job to the queue
#--  with...

#--  qsub sample_job.sh
##########################################


#PBS -j oe
#PBS -q debug

#
# Define DATADIR to be where the input files are
DATADIR=/home/dys0004/ReptileBloodTranscriptome/Thamnophis
#
# Define OUTDIR to be the place to run the trinity job from
OUTDIR=/scratch/ReptileTrinityDYS/Thamnophis/wBowtieRF.test15
#
#  Set the stack size to unlimited
ulimit -s unlimited
#
# Turn echo on so all commands are echoed in the output log
set -x
#
#
# Create OUTDIR, which we defined above, if it does not exist already
mkdir -p $OUTDIR
#
# Move to $OUTDIR
cd $OUTDIR
#
# Copy the input data from $DATADIR to where we are, $OUTDIR
cp $DATADIR/Thamnophis*.gz .
########################################################
##  Run Trinity to Generate Transcriptome Assemblies  ##
##  Run butterfly, generate final Trinity.fasta file  ##
########################################################
Trinity --max_memory 120G \
--seqType fq  --SS_lib_type RF \
--left Thamnophis*R1_paired.fastq.gz --right Thamnophis*R2_paired.fastq.gz \
--output trinity_out_dir >& trinity_all.log

##################
####   Done.  ####
##################
#
# Copy the output files back to your home directory
cp trinity_all.log /home/dys0004/ReptileBloodTranscriptome/Thamnophis
cp trinity_out_dir/Trinity.fasta /home/dys0004/ReptileBloodTranscriptome/Thamnophis/ThamnophisTSP.test15wBowtieRF.fasta

cd /home/dys0004/ReptileBloodTranscriptome/Thamnophis

#######BASIC STATS###
TRINITY_HOME/util/TrinityStats.pl ThamnophisTSP.test15wBowtieRF.fasta

TrinityStats.pl ThamnophisTSP.test15wBowtieRF.fasta