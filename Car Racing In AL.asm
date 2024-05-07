[org 0x0100]
jmp start

lap_time: dw 0,0,1		; Minutes & Seconds
speed: dw 0
background: dw 0,159,482,-160		; map, time ,index, iteration
upkey: dw 0
names: db '#10    Travis Head,','#05    David Grov,','#14    Cal Tyrone,','#42    Peter Axe,','#41    D Brandon,','#19    Alex Wave,','#03    Philips Kurtz,','#25    Tse Sakamoto,','#31    Kelvin Daye,'
qtime: dw 26,27,29,30,32,33,35,38,39,43
message: db 'Qualifying Round Results'
stop: dw 0

;-------------------------- SKY ----------------------- 5 rows
sky:
	mov di,0
	mov ax,0x0bdb
	mov cx,400
	cld
	rep stosw
	ret
	
;------------------------ Barrier --------------------- 1 row
barrier:
	mov di,800
	mov ax,0x1acf ;barrier
	mov bx,0x4eb0 ;audience
	mov cx,20
	red:
		mov [es:di],ax
		mov [es:di-160],bx
		mov [es:di-324],bx
		add di,2
		mov [es:di],ax
		mov [es:di-160],bx
		mov [es:di-324],bx
		add di,6
	loop red
	
	mov di,804
	mov ax,0x4acf ;barrier
	mov bx,0x1ab0 ;audience
	mov cx,20
	blue:
		mov [es:di],ax
		mov [es:di-160],bx
		mov [es:di-324],bx
		add di,2
		mov [es:di],ax
		mov [es:di-160],bx
		mov [es:di-324],bx
		add di,6
	loop blue
	
	mov di,640		;----- wrapping sky on sides of audience
	mov ax,0x0bdb
	mov cx,15
	cld
	rep stosw
	
	mov di,770
	mov cx,15
	rep stosw
	
	mov di,476
	mov cx,28
	rep stosw
	
	mov di,588
	mov cx,25
	rep stosw
	
	ret
	
;----------------------- Side Fields ------------------- 9 rows
fields:
	mov di,960
	mov ax,0x02db
	mov cx,720
	cld
	rep stosw
	ret
	
;-------------------------- Road ----------------------- 9 rows
road:
	mov ax,0x08db
	mov dx,1010
	mov bx,26
	mov cx,9
	again:
		push cx
		mov di,dx
		mov word[es:di+2],0x0edb
		mov word[es:di],0x0720
		add di,4
		mov cx,bx

		cld
		rep stosw
		mov word[es:di+2],0x0720
		mov word[es:di],0x0edb
		add bx,6
		add dx,154
		pop cx
	loop again
	
	mov di,1010
	mov ax,0x0fdb
	mov [es:di],ax
	mov [es:di+2],ax
	mov [es:di+56],ax
	mov [es:di+58],ax
	
	;---------- for displaying mid line of road
	mov bx,0x78dd
	mov word[es:1198],bx
	mov word[es:1358],bx
	
	mov word[es:1838],bx
	mov word[es:1998],bx
	
	mov bx,0x78de
	mov word[es:1200],bx
	mov word[es:1360],bx
	
	mov word[es:1840],bx
	mov word[es:2000],bx	
	
	ret
	
;------------------------- Bushes ---------------------
bushes:
	mov ax,0x2ab1
	mov di,1128
	mov cx,2
	loop1:
		mov [es:di],ax
		mov [es:di+2],ax
		mov [es:di+4],ax
		mov [es:di+160],ax
		mov [es:di+162],ax	
		mov [es:di-158],ax
		mov di,1748
	loop loop1
	
	mov word[es:1106],0x2ab2
	mov word[es:1108],0x2ab2
	ret
	
;---------------------- Corner Map --------------------
map:
	mov bx,0
	mov ax,0x3020
	mov dx,11
	mov cx,4
	cld
	l1:
		push cx
		mov di,bx
		mov cx,dx
		rep stosw
		pop cx
		add bx,160
	loop l1
	
	mov di,0
	mov word[es:di+2],0x30c9	; top left corner
	mov cx,3
	mov ax,0x30cd
	add di,4

	rep stosw
	mov word[es:di],0x30cb
	mov cx,3
	add di,2

	rep stosw
	mov word[es:di],0x30bb 		; top right corner

	mov word[es:di+160],0x30ba 	;right line
	mov word[es:di+320],0x30b9
	
	mov di,162
	mov word[es:di],0x30ba 		;left line
	mov word[es:di+160],0x30ba
	
	mov di,482
	mov word[es:di],0x30c8		; bottom left corner
	mov cx,2
	mov ax,0x30cd
	add di,2
	rep stosw
	mov word[es:di],0x30ca
	
	mov cx,4
	add di,2
	rep stosw
	mov word[es:di],0x30bc		; bottom right corner
	
	mov di,328					; mid line way
	mov word[es:di],0x30cc	
	mov word[es:di-160],0x30c9
	mov word[es:di+2],0x30ba
	mov word[es:di-158],0x30bc
	mov di,330
	mov cx,4
	mov ax, 0x30cd
	rep stosw

	ret
	
;---------------------- Lap & Time --------------------
laptime:
	mov di,140			;--- Double line border
	mov ax,0x6fcd
	mov word[es:di],0x6fc9
	mov word[es:di+160],0x6fba
	mov word[es:di+320],0x6fba
	mov word[es:di+480],0x6fc8
	add di,2
	mov cx,8
	cld
	rep stosw
	mov word[es:di],0x6fbb
	mov di,622
	mov cx,8
	rep stosw
	mov word[es:di],0x6fbc
	mov word[es:di-160],0x6fba
	mov word[es:di-320],0x6fba

	mov di,302
	mov word[es:di],0x6f50		;P
	mov word[es:di+2],0x603a	;:
	mov word[es:di+4],0x6030	;0
	mov word[es:di+6],0x6031	;1
	mov word[es:di+8],0x6f4c	;L
	mov word[es:di+10],0x603a	;:
	mov word[es:di+12],0x6030	;0
	mov word[es:di+14],0x6031	;1
	
	mov di,462
	mov word[es:di],0x6e30		;0
	mov word[es:di+2],0x6e30	;0
	mov word[es:di+4],0x603a	;:
	mov word[es:di+6],0x604d	;M
	mov word[es:di+8],0x6020
	mov word[es:di+10],0x6e30	;0
	mov word[es:di+12],0x6e30	;0
	mov word[es:di+14],0x6073	;s
	
	ret
	
;----------------------- Interior -------------------- 10 rows
interior:
	mov ax,0x04dd ; red strips
	mov cx,25
	mov di,2400
	cld
	rep stosw
	mov cx,25
	add di,60
	rep stosw
	
	mov di,2450 ; grey shade above steering
	mov ax,0x7020
	mov cx,8
	rep stosw
	mov cx,22
	mov ax,0x7fdf
	rep stosw
	
	mov word[es:di-4],0x72df
	mov word[es:di-2],0x7020
	
	mov ax,0x0f20 ; right and left side grey shade
	mov dx,2560
	mov bx,15
	mov cx,9
	ag:
		push cx
		mov di,dx
		mov cx,bx
		rep stosw
		
		mov ax,0x7020
		mov cx,50
		rep stosw
		
		mov ax,0x0f20
		mov cx,bx
		rep stosw
	
		add dx,160
		pop cx
	loop ag

	mov di,2590
	mov cx,5
	rep stosw
	add di,80
	mov cx,5
	rep stosw
	
	mov di,2750
	mov ax,0x70df
	mov cx,50
	rep stosw

	mov di,3114		;--- Speedo Meter Border
	mov ax,0x04cd
	mov word[es:di],0x04c9
	mov word[es:di+160],0x04ba
	mov word[es:di+320],0x04ba
	mov word[es:di+480],0x04c8
	add di,2
	mov cx,4
	cld
	rep stosw
	mov word[es:di],0x04bb
	mov di,3596
	mov cx,4
	rep stosw
	mov word[es:di],0x04bc
	mov word[es:di-160],0x04ba
	mov word[es:di-320],0x04ba
	
	mov di,3276
	mov word[es:di],0x0420		
	mov word[es:di+2],0x0f30	;0
	mov word[es:di+4],0x0f30	;0
	mov word[es:di+6],0x0420
	
	mov di,3436
	mov word[es:di],0x0420		
	mov word[es:di+2],0x0f30	;0
	mov word[es:di+4],0x0f30	;0
	mov word[es:di+6],0x0420
	
	mov ax,0x70db				; sides of speedo meter
	mov di,3288					
	mov word[es:di+6],0x0f3a ;:
	mov word[es:di+4],0x0f4c ;L
	mov word[es:di+2],0x0f49 ;I
	mov word[es:di],0x0f4f   ;O
	
	mov di,3448
	mov cx,4
	rep stosw
	
	mov di,3264
	mov word[es:di+6],0x0f50 ;P
	mov word[es:di+4],0x0f4d ;M
	mov word[es:di+2],0x0f45 ;E
	mov word[es:di],0x0f54   ;T
	
	mov di,3424
	mov cx,4
	rep stosw
	
	mov di,3000				; side buttons
	mov word[es:di],0x04db
	mov word[es:di+2],0x04db
	
	mov di,3480
	mov word[es:di],0x08db
	mov word[es:di+2],0x08db
	mov di,3800
	mov word[es:di],0x08db
	mov word[es:di+2],0x08db
	
	mov di,3556
	mov word[es:di],0x04db
	mov word[es:di+2],0x04db
	
	mov di,2916
	mov word[es:di],0x0adb
	mov word[es:di+2],0x0adb

	ret
	
;----------------------- Steering --------------------
steering:
	mov di,3724					; bottom line of steering
	mov ax,0x0020
	mov cx,18
	lu:
		mov [es:di],ax
		mov word[es:di+2],0x0020
		add di,4
	loop lu
	mov word[es:di-2],0x7020
	
	mov di,3884
	mov cx,18
	ld:
		mov word[es:di],0x0ffa
		mov word[es:di+2],0x0020
		add di,4
	loop ld
	mov word[es:di-2],0x7020
	
	mov di,3568
	mov word[es:di],0x0020
	mov word[es:di-2],0x0020
	mov [es:di-4],ax
	add di,64
	mov [es:di],ax
	mov word[es:di-2],0x0020
	mov word[es:di-4],0x0020
	
	mov di,3408					; side lines of steering
	mov bx,di
	mov cx,6
	mov dx,64
	lp:
		mov word[es:di],0x0020
		mov word[es:di-2],0x0020
		mov [es:di-4],ax
		add di,dx
		mov [es:di],ax
		mov word[es:di-2],0x0020
		mov word[es:di-4],0x0020
		sub dx,4
		mov di,bx
		sub di,158
		mov bx,di
	loop lp

	mov di,2458				; upper curve of steering
	mov word[es:di],0x0720
	mov word[es:di+2],0x0720
	
	mov word[es:di+36],0x0720
	mov word[es:di+34],0x0720
	
	mov di,2620
	mov word[es:di],0x0720
	mov word[es:di+2],0x0720
	mov word[es:di+34],0x0720
	mov word[es:di+36],0x0720
	

	mov di,2308					; top line of steering
	mov cx,12
	mov ax,0x08df
	rep stosw
	
	mov di,2462
	mov cx,19
	mov ax,0x0020
	rep stosw
	

	mov word[es:2480],0x0cdf	; red shade in mid of steering
	mov word[es:2478],0x0cdf

	mov di,3920					; middle of steering
	mov word[es:di],0x0fdf
	mov word[es:di-2],0x0fdf
	mov word[es:di-4],0x0f20
	mov word[es:di+2],0x0f20
	
	mov word[es:di-160],0x0fdc
	mov word[es:di-162],0x0fdc
	mov word[es:di-164],0x0f20
	mov word[es:di-158],0x0f20

	ret
	
;----------------------- Side Mirrors --------------------	
mirrors:
	mov di,2560			; left mirror
	mov cx,10
	mov ax,0x4bdc
	cld
	rep stosw
	mov ax,0x44db
	mov [es:di],ax
	mov [es:di+160],ax
	mov [es:di+320],ax
	mov [es:di+480],ax
	
	mov di,3040
	mov cx,10
	mov ax,0x48df
	rep stosw
	mov word[es:di-18],0x42df
	mov word[es:di-20],0x42df
	
	mov di,2880
	mov cx,10
	mov ax,0x48db
	rep stosw
	
	mov word[es:di-18],0x2020
	mov word[es:di-20],0x2020
	mov word[es:di-8],0x78de
	
	mov di,2720
	mov cx,10
	mov ax,0x4bdb
	rep stosw
	
	mov di,2718			; right mirror
	mov cx,10
	mov ax,0x4bdc
	std
	rep stosw
	mov ax,0x44db
	mov [es:di],ax
	mov [es:di+160],ax
	mov [es:di+320],ax
	mov [es:di+480],ax
	
	mov di,3198
	mov cx,10
	mov ax,0x48df
	rep stosw
	mov word[es:di+18],0x42df
	mov word[es:di+20],0x42df
	
	mov di,3038
	mov cx,10
	mov ax,0x48db
	rep stosw
	
	mov word[es:di+18],0x2020
	mov word[es:di+20],0x2020
	mov word[es:di+8],0x78dd
	
	mov di,2878
	mov cx,10
	mov ax,0x4bdb
	rep stosw

	ret
	
;------------------------------ Traffic Lights ----------------------------------
lightson:
	mov [es:di],ax
	mov [es:di+2],ax
	mov [es:di+10],ax
	mov [es:di+12],ax
ret
	
delay:
	mov ax,0
	mov cx,0xFFFF
	delay1:
		push cx
		mov ax,0x1010
		mov cx,0x000f
		delay2:
			mov ax,0
		loop delay2
		pop cx
	loop delay1
ret
	
trafficlight:
	mov di,0
	mov bx,12
	mov cx,7
	mov ax,0x0020
	cld
	nextline:
		push cx
		mov cx,bx
		rep stosw
		add di,136
		pop cx
	loop nextline
	
	call delay
	
	mov ax,0x4020
	mov di,164
	call lightson
	call delay
	mov ax,0x0edb
	mov di,484
	call lightson
	call delay
	mov ax,0x2020
	mov di,804
	call lightson
	call delay

ret

;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -------------------- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ----- Phase II ----- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -------------------- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

sec_back:
	mov dx,194
	mov cx,4
	mov ax,0x2fb0
	mount1:
		push cx
		mov di,dx
		mov cx,4
		mov bx,2
		nextrow:
			push di
			push cx
			mov cx,bx
			cld
			rep stosw
			add bx,4
			pop cx
			pop di
			add di,156
		loop nextrow
		add dx,30
		pop cx
	loop mount1
	mov ax,0x7fd8
	mov di,800
	mov cx,80
	rep stosw

	ret
	
third_back:
	mov ax,0x1020
	mov di,640
	mov cx,160
	rep stosw
	
	mov di,510
	mov cx,4
	mov ax,0x6020
	boat1:
		mov word[es:di],0x6f5c
		mov word[es:di+164],0x6f5c
		mov word[es:di+14],0x6f2f
		mov word[es:di+170],0x6f2f
		
		mov [es:di+2],ax
		mov [es:di+4],ax
		mov [es:di+6],ax
		mov [es:di+8],ax
		mov [es:di+10],ax
		mov [es:di+12],ax
		mov word[es:di+162],0x61dc
		mov [es:di+166],ax
		mov [es:di+168],ax
		mov word[es:di+172],0x61dc
		
		mov word[es:di-158],0x0f20
		mov word[es:di-156],0x0f20
		mov word[es:di-154],0x0f20
		mov word[es:di-152],0x0bdf	
		mov word[es:di-318],0x4fd8
		add di,30
	loop boat1
	ret
	
fourth_back:

	mov ax,0x6fd8
	mov di,640
	mov cx,80
	cld
	rep stosw
	mov ax,0x0adb
	mov di,800
	mov cx,80
	rep stosw

	mov dx,34
	mov cx,2
	tree:
		push cx
		mov di,dx
		mov ax,0x2020
		mov [es:di],ax
		mov [es:di+2],ax
		mov [es:di+156],ax
		mov [es:di+158],ax
		mov [es:di+166],ax
		mov [es:di+164],ax
		
		add di,312
		mov cx,10
		rep stosw
		mov di,dx
		
		mov ax,0x6020
		mov word[es:di+478],0x2bdc
		mov word[es:di+484],0x2bdc
		mov word[es:di+480],0x26dc
		mov word[es:di+482],0x26dc
		mov [es:di+640],ax
		mov [es:di+642],ax
		mov [es:di+800],ax
		mov [es:di+802],ax
		pop cx
		add dx,94
	loop tree
	
	mov ax,0x0edb
	mov di,396
	mov cx,14
	rep stosw
	
	mov di,554
	mov cx,16
	rep stosw
	
	mov ax,0x01db
	mov di,716
	mov cx,14
	rep stosw

	mov di,876
	mov cx,14
	rep stosw
	mov word[es:di-6],0x6020

	ret

;----------------------- Road Strips Moving --------------------
mover_strips:
	push es
	push ds
	
	mov ax,0xb800
	mov es,ax
	mov ds,ax
	mov si,2158		
	mov ax,[ds:si]	; stored last line to display on first
	push ax
	mov ax,[ds:si+2]
	push ax
	mov cx,7
	sub si,160
	mov di,2158
	moveloop:
		mov ax,[ds:si]
		mov bx,[ds:si+2]
		mov [es:di],ax
		mov [es:di+2],bx
		sub si,160
		sub di,160
	loop moveloop
	
	pop ax			; saving last line on first
	mov [es:di+2],ax
	pop ax
	mov [es:di],ax
	
	pop ds
	pop es
	ret
	
;----------------------- Road Sides Moving --------------------
mover_sides:
	push es
	push ds
	
	mov ax,0xb800
	mov es,ax
	mov ds,ax
	mov si,2242	
	mov ax,[ds:si]	; stored last line to display on first
	push ax
	mov ax,[ds:si+2]
	push ax
	mov ax,[ds:si+152]
	push ax
	mov ax,[ds:si+154]
	push ax

	mov cx,8
	sub si,154
	mov di,2242
	mov dx,152
	movesid:
		push si
		push di
		mov ax,[ds:si]
		mov bx,[ds:si+2]
		mov [es:di],ax
		mov [es:di+2],bx
		add di,dx
		add si,dx
		sub si,12
		sub dx,12
		mov ax,[ds:si]
		mov bx,[ds:si+2]
		mov [es:di],ax
		mov [es:di+2],bx			
		pop di
		pop si
		sub si,154
		sub di,154
	loop movesid
	
	mov di,1068
	pop ax			; saving last line on first
	mov [es:di],ax
	pop ax
	mov [es:di-2],ax
	pop ax
	mov [es:di-56],ax
	pop ax
	mov [es:di-58],ax
	
	pop ds
	pop es
	ret

;----------------------- Road Side Turn --------------------
roadturn:
	push es
	push ds
	push ax
	push bx
	push cx
	push dx
	mov ax,0xb800
	mov es,ax
	mov ds,ax
	mov dx,4
	more:
	mov si,2238
	mov di,2398
	mov cx,1120
	std
	rep movsw
	dec dx
	call rdelay
	jnz more
	
	mov di,1490
	mov cx,55
	mov ax,0x4eaf
	cld
	rep stosw
	
	mov di,1706		; right side road
	mov cx,27
	mov ax,0x08db
	rep stosw
	
	mov di,1872
	mov cx,24
	rep stosw
	mov di,2038
	mov cx,21
	rep stosw
	
	mov di,2204
	mov cx,6
	rep stosw
	
	mov word[es:di],0x0edb
	mov word[es:di+2],0x00db
	pop dx
	pop cx
	pop bx
	pop ax
	pop ds
	pop es
ret
	
rdelay:
	push ax
	push cx
	mov ax,0
	mov cx,0xFFFF
	rdelay1:
		mov ax,0x1010
	loop rdelay1
	pop cx
	pop ax
ret

removemap:
	mov bx,0
	mov ax,0x0bdb
	mov cx,4
	cld
	yes:
		push cx
		mov di,bx
		mov cx,11
		rep stosw
		add di,116
		mov cx,11
		rep stosw
		pop cx
		add bx,160
	loop yes
ret
	
;----------------------- Lap Timer  --------------------	
laptimeupdate:
	push es
	push ds
	push ax
	push bx
	push dx
	
	mov ax,0xb800
	mov es,ax
	
	mov ax,[cs:lap_time+2]
	cmp ax,600
	jne dontUpdate
	
	mov ax,0
	mov [cs:lap_time+2],ax
	
	mov ax,[cs:lap_time]
	inc ax
	mov [cs:lap_time],ax
	
dontUpdate:
	mov ax,[cs:lap_time+2]; printing seconds
	mov bx,10
	mov dx,0
	div bx
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x6e
	mov [es:474],dx
	
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x6e
	mov [es:472],dx
	
	mov ax,[cs:lap_time]; printing minutes
	mov bx,10
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x6e
	mov [es:464],dx
	
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x6e
	mov [es:462],dx
	
	mov ax,[cs:lap_time+2]
	inc ax
	mov [cs:lap_time+2],ax

	pop dx
	pop bx
	pop ax
	pop ds
	pop es
	ret
	
;----------------------- Speed Update --------------------	
speedupdate:
	push es
	push ds
	push ax
	push bx
	push dx
	
	mov ax,0xb800
	mov es,ax
	
	mov ax,[speed]
	cmp ax,120
	ja noUp
	
	shl ax,1
	mov bx,10
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x0f
	mov [es:3440],dx
	
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x0f	
	mov [es:3438],dx
	
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x0f
	mov [es:3280],dx
	mov ax,[speed]
	inc ax
	mov [speed],ax
noUp:

	pop dx
	pop bx
	pop ax
	pop ds
	pop es
	ret
	
;----------------------- Map Movement --------------------	
mapupdate:
	push es
	push ds
	push ax
	push bx
	push cx
	push dx
	
	mov ax,0xb800
	mov es,ax
backhere:
	mov ax,[background+2]

	cmp ax,0
	jbe nextmap
	
	mov dx,0
	mov bx,40
	div bx
	cmp dx,0
	jne exit1
	
	call map
	mov di,[background+4]
	mov dx,[background+6]
	mov word[es:di],0x3ffe
	
	add di,dx
	mov [background+4],di

exit1:
	mov ax,[background+2]
	dec ax
	mov [background+2],ax
	pop dx
	pop cx
	pop bx
	pop ax
	pop ds
	pop es
ret

nextmap:
	inc word[background]
	cmp word[background],5
	jne next
	mov word[stop],1
	jmp near check
	
	next:
	cmp word[background],1
	je b_1
	
	call removemap
	call roadturn
	
	getturn:
	in al,0x60
	cmp al,0x4d
	jne getturn
	
	call fields
	call road
	call bushes
	
		cmp word[background],2
		je b_2
		cmp word[background],3
		je b_3
		cmp word[background],4
		je b_4
	
	b_1:
		mov word[background+2],120
		mov word[background+4],482
		mov word[background+6],-160
		mov word[speed],50
		call sky
		call barrier
		call map
		call laptime
		jmp backhere
	b_2:
		mov word[background+2],320
		mov word[background+6],2
		mov word[speed],50
		call sky
		call sec_back
		call map
		call laptime
		jmp backhere
	
	b_3:
		mov word[background+2],120
		mov word[background+6],160
		mov word[speed],50
		call sky
		call third_back
		call map
		call laptime
		jmp backhere
		
	b_4:
		mov word[background+2],320
		mov word[background+6],-2
		mov word[speed],50
		call sky
		call fourth_back
		call map
		call laptime
		jmp backhere

;----------------------- Moving Grass  --------------------	
movegrass:
	push es
	push ds
	
	mov ax,0xb800
	mov es,ax
	mov ds,ax
	mov si,1920
	mov cx,2
both:				; to move both bushes
	push cx
	mov cx,7
	pshloop1:		; saving last line
		mov ax,[ds:si]
		push ax
		add si,2
	loop pshloop1
	
	sub si,14
	mov cx,6
	mov dx,si
	mov bx,dx
	sub bx,160
	grsloop1:
		push cx
		mov si,bx
		mov di,dx
		mov cx,7
		grsloop2:
			mov ax,[ds:si]
			mov [es:di],ax
			add si,2
			add di,2
		loop grsloop2
		sub bx,160
		sub dx,160
		pop cx
	loop grsloop1
	
	mov cx,7
	mov di,dx
	add di,12
	poploop1:		; storing last line on first
		pop ax
		mov [es:di],ax
		sub di,2
	loop poploop1
	
	mov si,2066
	pop cx
	loop both
	
	pop ds
	pop es
	ret
	
	
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -------------------- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ ----- Phase IV ---- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -------------------- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
printstr:
	push bp
	mov bp,sp
	push di
	push dx
	push es
	push ds
	cmp word[cs:lap_time+4],1
	jne near notmine
	
	mov ax,[cs:lap_time+2]
	mov dx,0
	mov cx,10
	div cx
	cmp ax,[qtime+bx]
	ja near notmine
		mov di,[bp+4]
		mov word[es:di],0x0e23		;#07
		mov word[es:di+2],0x0e30
		mov word[es:di+4],0x0e37
		
		mov word[es:di+14],0x0e50	;Player1
		mov word[es:di+16],0x0e6c
		mov word[es:di+18],0x0e61
		mov word[es:di+20],0x0e79
		mov word[es:di+22],0x0e65
		mov word[es:di+24],0x0e72
		mov word[es:di+26],0x0e31
		
		
		mov word[cs:lap_time+4],0
		mov di,[bp+4]
		add di,100
		
		mov ax,[cs:lap_time]
		mov cx,10
		mov dx,0
		div cx
		add dl,0x30
		mov dh,0x0e
		mov [es:di+2],dx
		mov word[es:di],0x0e30
		mov word[es:di+4],0x0e6d
		mov word[es:di+12],0x0e73
	
		mov ax,[cs:lap_time+2]
		mov cx,10
		mov dx,0
		div cx
		mov cx,10
		mov dx,0
		div cx
		add dl,0x30
		mov dh,0x0e
		mov [es:di+10],dx
		add al,0x30
		mov ah,0x0e
		mov [es:di+8],ax
		
		mov cx,0
		jmp position
	
	notmine:
	push ds
	pop es
	push di
	mov cx,0xffff
	mov al,0x2c
	repne scasb
	mov ax,0xffff
	sub ax,cx
	dec ax
	
	mov cx,ax
	pop si
	push cx
	
	mov ax,0xb800
	mov es,ax
	mov di,[bp+4]
	mov ah,0x0f
	
	cld
	nextchars:
		lodsb
		stosw
	loop nextchars
	pop cx
	inc cx
	
	
	;-------- Printing Time Taken ---------
	mov ax,[qtime+bx]
	push bx
	
	mov di,[bp+4]
	add di,100
	
	mov word[es:di],0x0f30
	mov word[es:di+2],0x0f31
	mov word[es:di+4],0x0f6d
	mov word[es:di+12],0x0f73
	
	
	mov bx,10
	mov dx,0
	div bx
	add dl,0x30
	mov dh,0x0f
	mov [es:di+10],dx
	add al,0x30
	mov ah,0x0f
	mov [es:di+8],ax
	pop bx
	;--------- Printing Position ---------
	position:
	mov di,[bp+4]
	mov ax,bx
	shr ax,1
	inc ax
	cmp ax,10
	je no_10
	mov ah,0x0f
	add al,0x30
	mov [es:di-14],ax
	jmp exittt
	no_10:
		mov word[es:di-14],0x0f31
		mov word[es:di-12],0x0f30
	
	exittt:
	pop ds
	pop es
		pop dx
		pop di
		pop bp
	ret 2

ndelay:
	push cx
	mov cx,0xFFFF
	ndelay1:
	push cx
		mov cx,0x0005
		ndelay2:
		loop ndelay2
	pop cx
	loop ndelay1
	pop cx
ret

printnames:
	mov cx,0
	mov dx,510
	mov di,names
	mov cx,10
	mov bx,0
	nextname:
		push cx
		add dx,320
		push dx
		call printstr
		call ndelay
		add di,cx
		add bx,2
		pop cx
	loop nextname
	
	ret
	
positiontable:
	push es
	push ds
	push ax
	push bx
	push cx
	push dx
	mov ax,0xb800
	mov es,ax
	mov di,0
	mov cx,160
	mov ax,0x4020
	rep stosw
	
	mov cx,24
	mov si,message
	mov di,210
	mov ah,0x4e
	mesloop
		lodsb
		stosw
	loop mesloop
	
	mov word[es:494],0x0c50 ;--- Pos.
	mov word[es:496],0x0c6f
	mov word[es:498],0x0c73
	mov word[es:500],0x0c2e
	
	mov word[es:510],0x0c4e ;--- No.
	mov word[es:512],0x0c6f
	mov word[es:514],0x0c2e
	
	mov word[es:528],0x0c4e ;--- Name
	mov word[es:530],0x0c61
	mov word[es:532],0x0c6d
	mov word[es:534],0x0c65
	
	mov word[es:612],0x0c54 ;--- Time
	mov word[es:614],0x0c69
	mov word[es:616],0x0c6d
	mov word[es:618],0x0c65
	
	call printnames
	pop dx
	pop cx
	pop bx
	pop ax
	pop ds
	pop es
ret

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>	
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
kbisr:
	push ax
	
	in al, 0x60
	cmp al,0x48
	jne nextcmp
	mov word[upkey],1
	jmp quit
	nextcmp:
	mov word[upkey],0
	
	quit:
		mov al,0x20
		out 0x20,al
		pop ax
		iret

timer:
	push ax
	push ds
	
	check:
	cmp word[stop],1
	jne movee
	
	mov cx,2000
	mov di,0
	mov ax,0x0720
	cld
	rep stosw
	push cs
	pop ds
	
	call positiontable
	
	getexit:
	in al,0x60
	cmp al,0x1c
	jne getexit
	
	movee:
		cmp word[upkey],0
		je nomove
	
	call mapupdate
	call speedupdate
	call mover_strips
	call mover_sides
	call movegrass
	
	nomove:
	call laptimeupdate
	
	end_timer:	
		
		mov al, 0x20
		out 0x20, al
		pop ds
		pop ax
	iret
	
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
start:
	mov ax,0xb800
	mov es,ax
	call sky
	call barrier
	call fields
	call road
	call bushes
	call map
	call laptime
	call interior
	call steering
	call mirrors
	call trafficlight
	
	call sky
	call barrier
	call fields
	call road
	call bushes
	call map
	call steering
	
		xor ax, ax
		mov es, ax
		
		cli
		mov word [es:9*4], kbisr
		mov [es:9*4+2], cs
		mov word [es:8*4], timer
		mov [es:8*4+2], cs
		sti

		mov dx, start
		add dx, 15
		mov cl, 4
		shr dx, cl


		mov ax, 0x3100

int 0x21