datasg	segment	para	'data'
mess1	db	'stock nember?',13,10,'$'

stoknin	label	byte
  max	db	3
  act	db	?
  stokn	db	3 dup(?)
;
stoktab	db	'05','    mess1   '
	db	'08','    mess2   '
	db	'09','    mess3   '
	db	'12','    mess4   '
	db	'23','    mess5   '
	db	'27','    mess6   '
;
descrn	db	14 dup(20h),13,10,'$'

mess	db	'Not in table!','$'
datasg ends

codesg	segment	para	'code'
	assume	cs:codesg,ds:datasg,es:datasg

main	proc	far
	push	ds
	sub	ax,ax
	push	ax

	mov	ax,datasg
	mov	ds,ax
	mov	es,ax

start:
	lea	dx,mess1
	mov	ah,09
	int	21h
	lea	dx,stoknin
	mov	ah,0ah
	int	21h
	cmp	act,0
	je	exit
	mov	al,stokn
	mov	ah,stokn+1
	mov	cx,06
	lea	si,stoktab

a20:
	cmp	ax,word ptr[si]
	je	a30
	add	si,14
	loop	a20
	lea	dx,mess
	mov	ah,09
	int	21h
	jmp	exit

a30:
	mov	cx,07
	lea	di,descrn
	rep	movsw

	lea	dx,descrn
	mov	ah,09
	int	21h
	jmp	start

exit:
	ret

main	endp
codesg	ends
	end	main
