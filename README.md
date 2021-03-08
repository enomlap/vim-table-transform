# vim-table-transform
Do tabled-data matrix transform.
This is a vim simple plugin to do data matrix transform.
For example,
-------------------------------------vim-----------------------------------------------------
AA BB CC DD EE FF GG HH II JJ
01 02 03 04 05 06 07 08 09 10
AA BB CC DD EE FF GG HH II JJ
01 02 03 04 05 06 07 08 09 10
AA BB CC DD EE FF GG HH II JJ
AA BB CC DD EE FF GG HH II JJ
-------------------------------------vim-----------------------------------------------------

after CTRL-V selected block, press '\dt' to recall this plugin, you'll got:

-------------------------------------vim-----------------------------------------------------
...
AA BB CC DD EE FF GG HH II JJ
01 02 03 04 05 06 07 08 09 10
<!!!=================== visual block is reformatted .>
 AA BB CC DD EE FF GG HH II JJ
 01 02 03 04 05 06 07 08 09 10
 AA BB CC DD EE FF GG HH II JJ
 01 02 03 04 05 06 07 08 09 10
 AA BB CC DD EE FF GG HH II JJ
<==================================== Make sure every line has same COLUMNS!!!========Total words for last line:11
 AA 01 AA 01 AA
 BB 02 BB 02 BB
 CC 03 CC 03 CC
 DD 04 DD 04 DD
 EE 05 EE 05 EE
 FF 06 FF 06 FF
 GG 07 GG 07 GG
 HH 08 HH 08 HH
 II 09 II 09 II
 JJ 10 JJ 10 JJ
>====================================
>...
>-------------------------------------vim-----------------------------------------------------
>
this just like matrix transform in numerical operation.


PS,this plugin use only minimal vim-script function, even vim version 6.3 can use it. No 'list','printf' functions are needed.
