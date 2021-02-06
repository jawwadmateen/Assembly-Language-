INCLUDE Irvine32.inc
genrand proto, ll : dword , ul : dword
decidefun proto , i :dword
choice proto , ans : dword
functioncall proto ,cho : dword
iqcalculator proto , scr : dword ,scro : dword

.data
welcome BYTE "****************WELCOME TO IQ QUIZ****************",0
cname BYTE "          ENTER YOUR NAME: ",0
ename BYTE 100 dup (?)
cage byte "          ENTER YOUR AGE : ",0
age dword ?
filehandle dword ?
filename byte "data.txt",0
press BYTE "                                                  PRESS 1 TO CONTNIUE ",0
wpress byte "YOU ENTERED WRONG NUMBER",0
pfun DWORD 15 dup (0)
f1q byte "WHAT IS THE NEXT NUMBER: ",0
f2qa byte "THE SUM OF ",0
f2qb byte " CONSECUTIVE NUMBERS IS ",0
f2qc byte " . WHAT IS THE ELEMENT ",0
f2qd byte " IN THIS SET , THE SET IS IN ASCENDING ORDER ?",0
f3q byte "WHAT NUMBER BEST COMPLETES THE ANALOGY ? ",0
f4aq byte "AT A CONFRENCE, ",0
f4bq byte " MEMBERS SHOOK HANDS WITH EACH OTHER BEFORE AND AFTER THE MEETING . HOW MANY TOTAL NUMBER OF HAND SHAKES OCCURRED ?",0
score dword 0
i dword 0
sc dword 0
arr dword 4 dup(0)
chs dword 4 dup (0)
f5qa byte "THERE ARE ",0
f5qb byte " TIMES AS MANY USED BIKES IN THE SHOWROOM AS THERE ARE NEW BIKES.THERE ARE ",0 
f5qc byte " TOTAL BIKES IN THE SHOWROOM.HOW MANY NEW BIKES ARE THERE IN THE SHOWROOM ?",0
f6qa byte "A CAR TRAVELS ",0
f6qb byte " FEET IN  ",0
f6qc byte " SECONDS.HOW FAR WILL IT GO IN ",0
f6qd byte " MINUTE(S) ?",0
f7qa byte "KEVIN IS ",0
f7qb byte " YEARS OLD AND HIS SISTER IS A THIRDS HIS AGE.WHEN KEVIN IS ",0
f7qc byte " ,WHAT WILL BE THE AGE OF HIS SISTER?",0
f8q byte "WHAT WILL BE THE AVERAGE OF ",0
avgarr dword 6 dup (0)
f9qa byte "A + A + A = ",0
f9qb byte "A + B = ",0
f9qc byte "2B + C = ",0
f9qd byte "A + B + C = ?",0
f10qa byte "MY BEST FRIEND WEIGHS ",0
f10qb byte "  KG HALF OF MY  FRIEND'S WEIGHT ",0
f10qc byte "AND MY BROTHER WHO IS YOUNGER THAN ME WEIGHS HALF OF MY BEST FRIEND'S WEIGHT",0
f10qd byte "CAN YOU GUESS MY BROTHER'S WEIGHT AS OUR WEIGHING SCALE IS NOT AVAILABLE AT THE MOMENT",0
f11qa byte "THE CANDIDATE HARRY WON THE ELECTIONS, RECIEVING ",0
f11qb byte " TIMES AS MANY VOTES AS JOHN.ERIC RECIEVED ",0
f11qc byte " % OF ALL VOTES.WHAT % OF VOTES DID HARRY RECIEVED ?",0
f12q byte "Which number replaces the ? mark",0
f13qa byte "AT ",0
f13qb byte " ,THE HOUR HAND AND THE MINUTE HAND OF A CLOCK FORM AN ANGLE OF....",0
f14qa byte "THE DAY AFTER THE DAY TOMORROW IS FOUR DAYS BEFORE MONDAY.",0
f14qb byte "WHAT DAY IS IT TODAY?(select 1 for mon,2 for tue,3 for wed,4 for thurs..)",0
f15q byte "WHICH OF THE FOLLOWING IS LEAP YEAR ?",0
result byte "                            CONGRATULATIONS YOUR IQ SCORE IS : ",0
correct byte "                            CORRECT ANSWERED : ",0
ending byte "                             THANK YOU",0
.code

main proc
call mainlayout
exit
main endp


mainlayout proc

mov eax,white+(blue * 16)
call settextcolor
call clrscr
mov edx,offset welcome
call writestring
call crlf
mov edx,offset cname
call writestring
mov edx,offset ename
mov ecx,lengthof ename
call readstring
call crlf
mov edx,offset cage 
call writestring
call readdec
mov age,eax

mov edx,offset press
call writestring
call readdec
cmp eax,1
jne l3
mov ecx,15
l2:
   mov edi,ecx
   call clrscr
   invoke decidefun, i
   mov eax,500
   call delay
   inc i
   mov ecx,edi
loop l2
jmp l4
l3:
  mov edx,offset wpress
  call writestring
  call readchar
  call mainlayout

l4:

invoke iqcalculator , score,sc
mov edx,offset ending
call writestring
call crlf
ret
mainlayout endp

decidefun proc , j :dword
local fun : dword 
l1:
  invoke genrand , 1,16
  mov fun,eax
  cmp j,0
  je l3
  mov ecx,j
  mov esi,0
  l2:
    mov eax,pfun[esi]
	cmp eax,fun
	je l1
	add esi,4
  loop l2
  l3:
	mov esi,j
	mov eax,fun
	mov pfun[esi * type pfun],eax
    invoke functioncall,fun
ret
decidefun endp

functioncall proc ,cho : dword
cmp cho,1
je l1
cmp cho,2
je l2
cmp cho,3
je l3
cmp cho,4
je l4
cmp cho,5
je l5
cmp cho,6
je l6
cmp cho,7
je l7
cmp cho,8
je l8
cmp cho,9
je l9
cmp cho,10
je l10
cmp cho,11
je l11
cmp cho,12
je l12
cmp cho,13
je l13
cmp cho,14
je l14
cmp cho,15
je l15
l1: call numberseries 
    jmp l16
l2:
    call permu
    jmp l16
l3: 
    call analogy
    jmp l16
l4: 
    call consecutivenum 
    jmp l16
l5: 
    call newbike
    jmp l16
l6: 
    call dist
    jmp l16
l7: 
    call sistage
    jmp l16
l8: 
    call dayz
    jmp l16
l9: 
    call vote
    jmp l16
l10: 
    call numprob
    jmp l16
l11: 
    call matricprob
    jmp l16
l12: 
    call weightprob
    jmp l16
l13:
    call clock 
    jmp l16
l14: 
    call leapyear
    jmp l16
l15: 
    call average
    jmp l16
l16:

ret
functioncall endp

numberseries proc
LOCAL  ft : dword , dif : dword , ans : dword ,last : dword
invoke genrand , 2,10
mov ft,eax
invoke genrand , 2,4
mov dif,eax
invoke genrand , 4,7
mov ecx,eax
mov last,eax
inc ecx
l1:
  mov eax,ft
  push ecx
  call writedec
  mov eax," "
  call writechar
  mov eax,dif
  mov ecx,3
  dec ecx
  mov esi,dif
  l2:
	mul esi
  loop l2
  mov ebx,ft
  add ebx,eax
  mov ft,ebx
  inc dif
  pop ecx
  cmp ecx,2
  jne l3
  mov ans,ebx
  jmp l4
  l3:
loop l1

l4:
   mov eax,"_"
   call writechar
   mov eax,100
   call delay
   call crlf 
   call crlf
   mov edx,offset f1q
   call writestring
   call crlf
   mov eax,100
   call delay
   invoke choice,ans

ret
numberseries endp

genrand proc, ll : dword , ul : dword
mov eax,200
call delay
l1:
  call randomize
  mov eax,ul
  call randomrange
  cmp eax,ll
  jl l1
ret
genrand endp

consecutivenum proc
local sum : dword , n : dword , element : dword , ans : dword
l1:
	invoke genrand, 100,200
	mov sum,eax
	invoke genrand, 3,7
	mov n,eax
	invoke genrand, 1,n
	mov element,eax
	mov eax,sum
	mov ebx,2
	mul ebx
	mov edx,0
	mov ecx,n
	div ecx
	mov ebx,n
	dec ebx
	sub eax,ebx
	mov edx,0
	mov ecx,2
	div ecx
	mov ans,eax
	cmp edx,0
	jne l1

mov edx,offset f2qa
call writestring
mov eax,n
call writedec
mov edx,offset f2qb
call writestring
mov eax,sum
call writedec
mov edx,offset f2qc
call writestring
mov eax,element
call writedec
mov edx,offset f2qd
call writestring

mov eax,ans
mov ebx,element
dec ebx
add eax,ebx
mov ans,eax

mov eax,100
call delay
call crlf
mov eax,200
call delay

invoke choice , ans

ret
consecutivenum endp

analogy proc
local n1 : dword , n2 : dword ,r : dword , n3 : dword , n4 : dword
mov edx,offset f3q
call writestring
call crlf
invoke genrand, 8,50
mov n1,eax
l1:
  invoke genrand , 2,n1
  mov n2,eax
  mov eax,n1
  mov edx,0
  mov ecx,n2
  div ecx
  cmp edx,0
  mov eax,100
  call delay
  jne l1
mov eax,n1
call writedec
mov eax,":"
call writechar
mov eax,n2
call writedec

mov edx,0
mov eax,n1
mov ecx,n2
div ecx
mov r,eax
mov eax, " "
call writechar 
 

l2:
	invoke genrand , n1,200
	mov edx,0
	mov n3,eax
	mov ecx,r
	div ecx
	mov n4,eax
	cmp edx,0
	jne l2

mov eax,n3
call writedec
mov eax,":"
call writechar

call crlf
mov eax,100
call delay
invoke choice , n4

ret
analogy endp

permu proc
local n : dword
invoke genrand , 7,16
mov n,eax
mov edx,offset f4aq 
call writestring
call writedec
mov edx,offset f4bq
call writestring

mov ecx,n
dec ecx
mov eax,0
mov ebx,n
l1:
  dec ebx
  add eax,ebx
loop l1
call crlf
invoke choice , eax

ret
permu endp

newbike proc
local na1:dword,na2:dword,na3:dword
mov edx,offset f5qa
call writestring
invoke genrand,2,6
call writedec
mov na1,eax
mov edx,offset f5qb
call writestring
invoke genrand,12,16
call writedec
mov na2,eax
mov edx,offset f5qc
call writestring
call crlf
mov edx,0
mov eax,na2
mov ebx,na1
div ebx
mov na3,eax
invoke choice,na3
ret
newbike endp

dist proc
local w1:dword,w2:dword,w3:dword,w4:dword 
mov edx,offset f6qa
call writestring
invoke genrand,2,12
call writedec
mov w1,eax
mov edx,offset f6qb
call writestring
mov eax,200
call delay
invoke genrand,2,w1
mov w2,eax
call writedec
mov edx,offset f6qc
call writestring
invoke genrand,1,10
mov w3,eax
call writedec
mov edx,offset f6qd
call writestring
call crlf
mov edx,0
mov eax,w1
mov ebx,w2
div ebx
mov ecx,eax
mov eax,60
mov ebx,w3
mul ebx
mov ebx,ecx
mul ebx
mov w4,eax
invoke choice,w4
ret
dist endp

sistage proc
local u1:dword,u2:dword,u3:dword,u4:dword
mov edx,offset f7qa
call writestring
invoke genrand,16,30
mov u1,eax
call writedec
mov edx,offset f7qb
call writestring
invoke genrand,30,40
mov u2,eax
call writedec
mov edx,offset f7qc
call writestring
call crlf
mov eax,u2
sub eax,u1
mov u2,eax
mov u3,3
mov edx,0
mov eax,u1
mov ebx,u3
div ebx
add eax,u2
mov u4,eax
invoke choice,u4
ret
sistage endp

average proc
local terms : dword , n : dword , ans : dword
invoke genrand, 3,6
mov terms,eax
mov edx,offset f8q
call writestring
mov eax,300
call delay
mov esi,0
mov n,1
l1:
  mov eax,n
  cmp eax,terms
  jg l2
  invoke genrand , 10,300
  mov ecx,n
  push esi
  mov esi,0
  l3:
    cmp eax,avgarr[esi]
	jne l4
	mov ebx,1
	l4:
	add esi,4
  loop l3
  cmp ebx,1
  je l1
  pop esi
  call writedec
  mov avgarr[esi],eax
  mov eax,","
  call writechar
  add esi,4
  inc n
  jmp l1

l2: 
  mov eax,"?"
  call writechar

  mov ecx,terms 
  mov esi,0
  mov eax,0
  l5:
    mov ebx,avgarr[esi]
    add eax,ebx
    add esi,4
  loop l5

  mov edx,0
  mov ecx,terms
  div ecx
  mov ans,eax
  call crlf
  mov eax,300
  call delay
  invoke choice,ans

ret
average endp


numprob proc
local t1:dword,t2:dword,t3:dword,t4:dword
mov edx,offset f9qa
call writestring
invoke genrand,24,30
call writedec
mov t1,eax
mov ebx,3
mov edx,0
div ebx
mov t1,eax
call crlf
mov edx,offset f9qb
call writestring
mov t2,eax
mov ebx,t2
add ebx,4
mov t2,ebx
mov eax,ebx
add eax,t1
call writedec
call crlf
mov edx,offset f9qc
call writestring
mov edx,0
mov eax,t2
mov ebx,2
div ebx
mov t3,eax
mov edx,0
mov eax,t2
mov ebx,2
mul ebx
add eax,t3
call writedec
call crlf
mov edx,offset f9qd
call writestring
call crlf
mov eax,t1
add eax,t2
add eax,t3
mov t4,eax

invoke choice,t4

ret
numprob endp


weightprob proc
local we1:dword,we2:dword,we3:dword
mov edx,offset f10qa
call writestring
invoke genrand,60,80
mov we1,eax
call writedec
mov edx,offset f10qb
call writestring
call crlf
mov edx,offset f10qc
call writestring
call crlf
mov edx,offset f10qd
call writestring
call crlf
mov ebx,2
mov edx,0
div ebx
mov edx,0
mov we2,eax
div ebx
mov we3,eax

invoke choice,we3

ret
weightprob endp


matricprob proc
local er1:dword,er2:dword,er4:dword,er5:dword,er7:dword,er8:dword,er9:dword
invoke genrand,1,5
mov er1,eax
call writedec
mov eax," "
call writechar
invoke genrand,6,9
mov er2,eax
call writedec
mov eax," "
call writechar
mov eax,0
add eax,er1
add eax,er2
call writedec
call crlf
invoke genrand,1,5
mov er4,eax
call writedec
mov eax," "
call writechar
invoke genrand,6,9
mov er5,eax
call writedec
mov eax," "
call writechar
mov eax,0
add eax,er4
add eax,er5
call writedec
call crlf
invoke genrand,1,5
mov er7,eax
call writedec
mov eax," "
call writechar
invoke genrand,6,9
mov er8,eax
call writedec
mov eax," "
call writechar
mov eax,'?'
call writechar
call crlf
mov edx,offset f12q
call writestring
call crlf
mov eax,0
add eax,er7
add eax,er8
mov er9,eax

invoke choice,er9

ret
matricprob endp


vote proc
local v1:dword,v2 : dword ,ans : dword

mov edx,offset f11qa
call writestring
invoke genrand, 2,6
mov v1,eax
call writedec
mov edx,offset f11qb
call writestring
invoke genrand , 20,60
call writedec
mov v2,eax
mov edx,offset f11qc
call writestring
mov edx,0
mov eax,100
sub eax,v2
mov ecx,1
add ecx,v1
div ecx
mov ebx,v1
mul ebx

mov ans,eax

mov eax,100
call delay

call crlf

invoke choice,ans

ret
vote endp


clock proc
local c1:dword , c2 : dword , c3 : dword , ans : dword
mov edx,offset f13qa
call writestring
invoke genrand , 1,12
call writedec
mov c1,eax
mov eax,":"
call writechar
invoke genrand, 1,60
mov c2,eax
call writedec
mov edx,offset f13qb
call writestring
mov eax,c1
mov ebx,60
mul ebx
add eax,c2
mov edx,0
mov ecx,60
div ecx
mov ebx,30
mul ebx
mov c3,eax
mov eax,360
mov ebx,c2
mul ebx
mov edx,0
mov ecx,60
div ecx

mov ebx,c3
sub ebx,eax
mov ans,ebx

call crlf

mov eax,100
call delay
invoke choice , ebx

ret
clock endp


dayz proc
local d1:dword
mov eax,1
mov d1,eax
mov edx,offset f14qa
call writestring
call crlf
mov edx,offset f14qb
call writestring
call crlf
invoke choice,d1
ret
dayz endp


leapyear proc
local n1:dword
mov edx,offset f15q
call writestring
l1:
  invoke genrand,1900,2021
  mov n1,eax
  mov edx,0
  mov ecx,4
  div ecx
  cmp edx,0
  je l2
  jmp l1
  l2:
    mov edx,0
    mov eax,n1
	mov ecx,100
	div ecx
	cmp edx,0
	jne l3
	l4:
	  mov edx,0
	  mov eax,n1
	  mov ecx,400
	  div ecx
	  cmp edx,0
	  jne l1

l3:

mov eax,100
call delay
call crlf

invoke choice , n1


ret
leapyear endp


iqcalculator proc , scr : dword ,scro : dword

call clrscr
mov edx, offset result
call writestring
mov eax,scr
call writedec
call crlf
call crlf
mov edx,offset correct
call writestring
mov eax,scro
call writedec
call crlf
ret
iqcalculator endp



choice proc , ans : dword
local flag : dword , n : dword , guess : dword

mov ecx,4
mov esi,0
l10:
   mov ebx,0
   mov chs[esi],ebx
   add esi,4
loop l10

mov ecx,4
mov esi,0
l11:
   mov ebx,0
   mov arr[esi],ebx
   add esi,4
loop l11

mov eax,100
call delay

mov n,0
mov ebx,ans
sub ebx,20
mov edx,ans
add edx,20
l1:
  cmp n,2
  jg l4
  invoke genrand ,ebx,edx
  mov flag,0
  mov ecx,n
  mov esi,0
  cmp n,0
  je l13
  l2:
    mov ebx,ecx
    cmp chs[esi],eax
	jne l3
	mov flag,1
	l3:
	add esi,4
	mov ecx,ebx
  loop l2
  cmp flag,0
  jne l1
  l13:
  mov esi,n
  mov chs[esi * type chs],eax 
  inc n
  jmp l1

l4:
mov esi,12
mov eax,ans
mov chs[esi],eax
mov n,0
l5:
   cmp n,3
   jg l8
   invoke genrand ,0,5
   mov ecx,4
   mov esi,0
   mov flag,0
   cmp n,0
   je l14
   l6:
     mov ebx,ecx
     cmp arr[esi],eax
	 jne l7
	 mov flag,1
	 l7:
	 add esi,4
	 mov ecx,ebx
   loop l6
   cmp flag,0
   jne l5
   l14:
   mov esi,n
   mov ebx,eax
   mov arr[esi * type arr],ebx
   mov eax,n
   inc eax
   call writedec
   mov eax,":"
   call writechar
   mov eax," "
   call writechar
   mov esi,ebx
   dec esi
   mov eax,chs[esi * type chs]
   call writedec
   call crlf
   inc n
   jmp l5

l8:

call readdec
mov guess,eax
dec eax
mov esi,eax
mov ebx,arr[esi * type arr]
mov esi,ebx
dec esi
mov eax,chs[esi * type chs]
cmp eax,ans
jne l9
add score,10
inc sc
l9:
ret
choice endp

end main