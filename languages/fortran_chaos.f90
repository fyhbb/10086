program chaos_calc
  implicit none
  integer :: a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
  real :: result,tmp,pi=3.14159265358979
  character(len=20) :: input
  logical :: flag=.true.
  integer :: counter=0,MAX_TRIES=7,secret=42,guess=0
  integer :: arr(10)
  data arr/3,1,4,1,5,9,2,6,5,3/

  print *,"=== CHAOS CALCULATOR v0.0.1 ==="
  print *,"(buggy but functional!)"

  do while(flag)
    print *,""
    print *,"1) Add  2) Sub  3) Mul  4) Div  5) Mod"
    print *,"6) Power  7) Pi*  8) Guess Game  9) Array Sort  0) Quit"
    print *,"Choice: "
    read *,a

    select case(a)
      case(1)
        print *,"Enter two nums: "
        read *,b,c
        result = real(b) + real(c)
        print *,"Result = ",result
      case(2)
        print *,"Enter two nums: "
        read *,b,c
        result = real(b) - real(c)
        print *,"Result = ",result
      case(3)
        print *,"Enter two nums: "
        read *,b,c
        result = real(b) * real(c)
        print *,"Result = ",result
      case(4)
        print *,"Enter two nums: "
        read *,b,c
        if(c /= 0) then
          result = real(b) / real(c)
          print *,"Result = ",result
        else
          print *,"NO DIV BY ZERO!!! (you almost broke it)"
        end if
      case(5)
        print *,"Enter two nums: "
        read *,b,c
        if(c /= 0) then
          print *,"Mod = ",mod(b,c)
        else
          print *,"no."
        end if
      case(6)
        print *,"base exp: "
        read *,b,c
        result = real(b) ** real(c)
        print *,"Result = ",result
      case(7)
        print *,"pi = ",pi
        print *,"2*pi = ",2.0*pi
        print *,"pi/2 = ",pi/2.0
      case(8)
        secret = mod(abs(b+c+counter),100)+1
        print *,"Guess 1-100! You have ",MAX_TRIES," tries"
        do i=1,MAX_TRIES
          print *,"Guess #",i,": "
          read *,guess
          if(guess == secret) then
            print *,"YOU WIN in ",i," tries!"
            exit
          else if(guess < secret) then
            print *,"Too low!"
          else
            print *,"Too high!"
          end if
        end do
        if(guess /= secret) print *,"The answer was ",secret
      case(9)
        print *,"Sorting array..."
        do i=1,9
          do j=i+1,10
            if(arr(i) > arr(j)) then
              k = arr(i)
              arr(i) = arr(j)
              arr(j) = k
            end if
          end do
        end do
        print *,"Sorted: ",arr
      case(0)
        flag = .false.
        print *,"Bye! (program exited with dignity... not)"
      case default
        print *,"Invalid choice. Try harder."
    end select
    counter = counter + 1
  end do

end program chaos_calc
