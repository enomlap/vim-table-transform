" Vim plugin for perform Transform for given lines.
" Maintainer: zuohj
" Last Change: 2021 Mar 4

" Don't do this when:
" - when 'compatible' is set
" - this plugin was already loaded
if !&cp && !exists("s:loaded_trans")
	let s:loaded_trans=1
	"unmap <Leader>dt
	vmap <unique> <Leader>dt <Plug>DoTrans
	vmap <silent> <script> <Plug>DoTrans  :<C-U>set lz<CR>:call <SID>DoTrans(line("'<"),line("'>"))<CR>:set nolz<CR>
	"<C-U> : exit from visual mode to normal mode, I.E, no #'<,'> ...#

	function! <SID>DoTrans(lineA, lineB)
		if a:lineB >= a:lineA
			let line1= a:lineA
			let line2= a:lineB
		else
			let line1= a:lineB
			let line2= a:lineA
		endif
		let maxC=1024

		" first scaning:
		" *1>, determine max word length
		" *2(TODO:not completed now)>, check if every line has same columns
		let wordC=0
		let word_width=0
		let tmp_e=0
		while tmp_e>=0 && wordC<maxC
			let i=line1
			while i <= line2
				let cur_l=getline(i)
				let t_start=match(cur_l,'\S\+',tmp_e)
				let t_end=matchend(cur_l,'\S\+',tmp_e)
				if word_width < t_end-t_start
					let word_width = t_end-t_start
				endif
				let i=i+1
			endwhile
			let tmp_e=t_end 
			"TODO: here assume every tmp_e for each line is same...
			let wordC=wordC+1
		endwhile

		" second scaning,reformating each line
		let i=line1
		while i <= line2
			let cur_l=getline(i)
			let tmp_e=0
			let tmp_line=""
			while tmp_e>=0
				let t_start=match(cur_l,'\S\+',tmp_e)
				let t_end=matchend(cur_l,'\S\+',tmp_e)
				let tmp_e=t_end
				" old version of vim does not has printf function, but I can do this:
				let tmp_word="                                                                " . strpart(cur_l,t_start,t_end-t_start)
				let tmp_l=strlen(tmp_word)
				let tmp_line=tmp_line . " " . strpart(tmp_word,tmp_l-word_width)
				call setline(i,tmp_line)
			endwhile
			let i=i+1
		endwhile

		" third scaning
		let wordC=0
		let tmp_e=0
		while tmp_e>=0 && wordC<maxC
			let tmp_line=""
			let i=line1
			while i <= line2
				let cur_l=getline(i)
				let t_start=match(cur_l,'\S\+',tmp_e)
				let t_end=matchend(cur_l,'\S\+',tmp_e)
				" old version of vim does not has printf function, but I can do this:
				let tmp_word="                                                                " . strpart(cur_l,t_start,t_end-t_start)
				let tmp_l=strlen(tmp_word)
				let tmp_line=tmp_line . " " . strpart(tmp_word,tmp_l-word_width)
				let i=i+1
			endwhile
			let tmp_e=t_end 
			"TODO: here assume every tmp_e for each line is same...
			let wordC=wordC+1
			call append(line2, "".tmp_line)
		endwhile


                ' reverse lines.
		let i=0
		while i<(wordC/2)
			let tmp_line=getline(line2+1+i)
			call setline(line2+1+i,getline(line2+wordC-i))
			call setline(line2+wordC-i,tmp_line)
			let i=i+1
		endwhile


		call append(line2,'<==================================== Make sure every line has same COLUMNS!!!========Total words for last line:'.wordC)
		call append(line2+wordC,'>==================================== ')
		call append(line1-1,'<!!!=================== visual block is reformatted .>')


	endfunc

	function! ToStr(v,d)
		" TODO: assert int1<10^5,d<5
		let tstr=strpart("        ",0,a:d) . a:v
		return strpart(strpart(tstr,0,a:d) . a:v,strlen(tstr)-a:d,a:d)
	endfunc


endif

