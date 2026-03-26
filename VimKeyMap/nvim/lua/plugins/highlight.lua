return {
  {
    "ESSO0428/bioSyntax-vim",
    ft = {
      "fasta",
      "fastq",
      "sam",
      "bam",
      "vcf",
      "bed",
      "gtf",
      "pdb",
      "nexus",
      "clustal",
      "cwl",
      "pml",
      "flagstat",
      "faidx",
    },
  },
  {
    "folke/todo-comments.nvim",
    -- event = "VimEnter",
    event = "User FileOpened",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },
}
