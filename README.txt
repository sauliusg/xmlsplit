xmlcat:

  Concatenate several XML files into a stream.

xmlsplit:

  Split concatenated XML file stream into separate XML files. Each
  resulting file will be well-formed if the original files were
  well-formed before concatenation.

 USAGE:
     xmlsplit --options input1.xmlcat input*.xmlcat
     xmlsplit --options < input.xmlcat
 
 OPTIONS:
    -d, --digits 4         Use specified number of digits (0-paded) to number files.
    -h, --header '<xml? '  Use the specified XML header as the stream delimiter
                           (useful values are '<?xml ' (default), '<!DOCTYPE ').
    -o, --output-dir .     Specify output directory name. Output tree is created if needed.
    -p, --prefix xmlsplit_ Specify file prefix. Prefix may contain '/' after exisitng dirs.
    -s, --suffix .xml      Specify the suffix (extension) of the created files.
    --help,--usage         Print a short usage message (this message) and exit.

xmlxargs:

  Split concatenated XML file stream into separate XML files and run
  the program that is specified on the command line, in the manner
  'xargs' does it for the arguments read from STDIN.

 USAGE:
     xmlxargs --options command --command-options < input.xmlcat
 
     e.g.:
     xmlxargs --options xmllint --noout < input.xmlcat
     xmlxargs --options md5sum < input.xmlcat
 
 OPTIONS:
    -D, --digits 4         Use specified number of digits (0-paded) to number files.
    -h, --header '<xml? '  Use the specified XML header as the stream delimiter
                           (useful values are '<?xml ' (default), '<!DOCTYPE ').
    -i, --replace          Replace '{}' with each file name in the command.
    -I, --insert XYZ       Replace 'XYZ' with each file name in the command.
    -n, --nargs 10         Specify number of arguments for each run (default - unlimited).
    -p, --prefix xmlxargs_ Specify file prefix. Prefix may contain '/' after exisitng dirs.
    -s, --suffix .xml      Specify the suffix (extension) of the created files.
    -d, --tmp-dir /tmp     Specify name of the temporary directory. The directory must exist.
    --help,--usage         Print a short usage message (this message) and exit.
    --debug, --no-debug    Print/do not print internal debug values.

