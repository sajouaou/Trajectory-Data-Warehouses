import os
extime = []
for i in range(1,8):
    filename = "output" + str(i) + ".txt"
    output_file = open(filename)
    extime += [round(float(line.split("ms")[0][6:-1].replace(',','.')) /1000,3) for line in output_file.readlines() if "Time: " in line]
    output_file.close()
    os.remove(filename)

latex_output = "\\begin{tabular}{ p{3cm}|p{4cm}  } \n"+\
               "\\hline\n" + \
               "\\textbf{Query} & \\textbf{Execution Time (s)}\\\\\n" +\
               "\\hline\n"

for i in range(len(extime)):
    latex_output += "Q" + str(i+1) + " & " + str(extime[i]) + " \\\\\n"

latex_output += "\\hline\n" + \
                "\\end{tabular}"

print(latex_output)
