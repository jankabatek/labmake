{smcl}
{* *! version 1.0.0  28apr2023}{...} 
{vieweralsosee "[D] label" "help label"}{...} 
{title:Title} 

{phang}
{bf:labmake} {hline 2} Create a value label from a set of reference variables


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:labmake} {it:lblname} 
{cmd:,} {opth v:alues(varname)} {opth l:abels(varname)} [{opt a:dd} {opt modify} {opt replace} {opt nofix} {opt show}]

{p 8 17 2}where {it:lblname} is the name of the label. 

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Source variables}
{synopt:{opth v:alues(varname)}}is a numeric variable that stores the values (that are being labelled){p_end}
{synopt:{opth l:abels(varname)}}is a string variable that stores the labels (that correspond to the values){p_end}

{syntab:Editing options}
{synopt:{opt a:dd}}allows you to add values to an existing label{p_end}
{synopt:{opt modify}}allows you to modify values of an existing label. Specifying {opt modify} implies {opt add}.{p_end}
{synopt:{opt replace}}allows you to replace an existing existing label{p_end}
{synopt:{opt nofix}}prevents display formats from being widened according to the
maximum length of the value label{p_end}

{syntab:Reporting options}
{synopt:{opt show}}display the contents of the value label{p_end}
{synoptline}
{p2colreset}{...} 


{marker description}{...}
{title:Description}

{pstd}
{cmd:labmake} is a command for automated generation of value labels in situtations when you have a codebook that lists the variable {bf:values} and the corresponding value {bf:labels} in the following format:

    +-------------------+
    |  values    labels |
    |-------------------|
    |      1     Gold   |
    |      2     Silver |
    |      3     Bronze | 
    +-------------------+
	
{pstd}
Once you have loaded the two variables into Stata, you should specify their names using the {bf:labels()} and {bf:values()} options, choose the name of your value label, and (if 
applicable) select additional options that have been ported directly from {it:{help label define}}
	
{pstd}
To save the resulting label into a do-file, use the {it:{help label save}} command. 

{marker examples}{...}
{title:Examples}

    Create a new value label:
{phang2}{cmd:. webuse set https://www.jankabatek.com/datasets/}{p_end}
{phang2}{cmd:. webuse ozstates.dta, clear}{p_end}

{phang2}{cmd:. labmake states, values(state_code) labels(state_name)}{p_end}
{phang2}{cmd:. label list states}{p_end}

    {hline}

{marker contact}{...}
{title:Contact}

{phang2}Jan Kabátek, The University of Melbourne{p_end}
{phang2}j.kabatek@unimelb.edu.au{p_end} 
