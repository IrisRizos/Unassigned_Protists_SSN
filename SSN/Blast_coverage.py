from Bio import SeqIO, SearchIO
import argparse


def arguments():
    """
    set arguments
    """

    parser = argparse.ArgumentParser()

    # Mandatory arguments
    parser.add_argument("-b", "--blast_file", dest="blast_file",
                        type=str, required=False,
                        help="blast_file")
    parser.add_argument("-f", "--fasta_file", dest="fasta_file",
                        type=str, required=False,
                        help="fasta_file")


    return parser.parse_args()


def get_fasta_sequence_length(fasta_file):
	
	name = {"ASV_": "ASV", "Ast_": "Ast", "Sol_": "Sol", "BBMO_": "BBMO",
	"Moo_": "Moo", "Mal_": "Mal", "Biom_Napl_": "BiomNapl", "Biom_Rosc_":"BiomRosc",
	"Biom_Gij_": "BiomGij", "Biom_Osl_": "BiomOsl", "Biom_Bar_": "BiomBar",
	"Biom_Var_": "BiomVar"}
	d = {}
	
	records = SeqIO.parse(open(fasta_file), "fasta")
	for record in records:
		for k, v in name.items():
			if k in record.id:
				record.id = record.id.replace(k, v)
		
		d[record.id] = len(record.seq)

	with open("seq_length", "w") as out:
		for k, v in d.items():
			print(f"{k}\t{v}", file=out)
	
	return d


def get_coverage(blast_file, length):
	coverage_q = {}
	coverage_s = {}
	blast_qresult = SearchIO.parse(blast_file, "blast-tab")

	for query in blast_qresult:
		for hit in query:
			for hsp in hit:
				total_matched_s = sum([x.hit_span for x in hsp.fragments])
				total_matched_q = sum([x.query_span for x in hsp.fragments])
				coverage_q[query.id] = round(100 * total_matched_q / length[query.id], 2)
				coverage_s[hit.id] = round(100 * total_matched_s / length[hit.id], 2)


	return coverage_q, coverage_s


def append_blast_output(blast_file, coverage_q, coverage_s):
	fout = open("blast_file_with_cov", "w")
	with open(blast_file, "r") as fin:
		for line in fin:
			llist = line.strip().split("\t")
			q = llist[0]
			cov_q = coverage_q[q]
			llist.append(str(cov_q))
			s = llist[1]
			cov_s = coverage_s[s]
			llist.append(str(cov_s))
			line = "\t".join(llist)
			print(line, file = fout)


def main():

	args = arguments()
	length = get_fasta_sequence_length(args.fasta_file)
	coverage_q, coverage_s = get_coverage(args.blast_file, length)
	append_blast_output(args.blast_file, coverage_q, coverage_s)



if __name__ == '__main__':
	main()