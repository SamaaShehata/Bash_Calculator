#!/bin/bash
readarray -t newtcols < /etc/newt/palette

newtcols_error=(
root=white,gray
window=gray,white
border=white,magenta
shadow=white,gray
button=white,magenta
actbutton=black,white
compactbutton=black,lightgray
title=magenta,
roottext=black,magenta
textbox=magenta,white
acttextbox=black,white
entry=lightgray,gray
disentry=gray,lightgray
checkbox=black,lightgray
actcheckbox=black,lightgray
emptyscale=,black
fullscale=white,magenta
listbox=black,lightgray
actlistbox=white,lightgray
actsellistbox=white,yellow
)

NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Bash Calculator" --msgbox "Welcome to the bash calculator .. 💜" 15 80


######################################################################
########################### main menu function #######################

function MainMenu() {

    menu=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Bash Calculator" --fb  --cancel-button "Exit" --menu "Choose an option" 25 70 4 \
        "1" "Start Calculator" \
        "2" "Documentation" \
         3>&1 1>&2 2>&3 )
    if [ -z "$menu" ]
    then 
            if (NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Exit" --yesno "Do you really want to exit the calculator? 😢 " 10 70)
            then
            exit
            else
            MainMenu
            fi
    else
    case $menu in
        1)            
            calculations
        ;;
	2)
            documentation
        ;;
    esac
    fi
}

#########################################################################
##################### documentation function ############################
 #back
function documentation {
	
	doc=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Documentation 📝" --cancel-button "🔙" --ok-button "🆗" --menu "Choose an option" 25 70 4 \
        "1" "Calculator Manual" \
        "2" "Authors" \
        3>&1 1>&2 2>&3 )
        
        if [ -z "$doc" ]
    	then 
            MainMenu
    	else

        case $doc in
        1)   
                    
            manual
            ;;
	2)
         
            authors
            ;;
    	esac
	fi  
}       

####################### manual function ##################################
function manual {

	if (NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Manual 📋" --yesno "How to use the calculator?
        - To navigate through the calculator use the arrows ↑ ↓ → ←
        - To exit the calculator choose the button 'Exit'.
        - use Delete/Backspace to delete one character at a time from the right end or the left 
        end of the display.
        
  	► Standard Calculator:
  	- It is a simple basic calculator similar to a small handheld calculator. 
  	- Use can use this basic calculator for math with addition, subtraction, division, 
  	multiplication, power, and factorial.

  	► Bitwise Calculator:
  	- This calculator contains some of the bitwise operations and bit shifting.
  	- Operations include: 
  		1. Right Shift 2. Left Shift 3. AND  4. OR  5. XOR  6. NOT 	

	► Programmer Calculator:
	- This calculator claculates the conversions between different number systems.
	- You can do all kinds of conversions between Binary, Octal, Decimal, and Hex-Decimal.
	
     	" 25 100 --yes-button "Back" --no-button "Exit") 
        then
	documentation
        else
	if (NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Exit" --yesno "Do you really want to exit the calculator? 😢 " 25 70)
            then
            exit
            else
            manual
            fi
	fi
}

############################## authors function ##############################
function authors {
	if (NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Team Members 👩‍💻" --yesno "
	
	- Made by: 
	
	►Esraa Adel: The Basic Script 
        
        ►Reham Ramadan: Bitwise Calculations
        
        ►Salma Amir: Programmer Calculations
        
        ►Samaa Hamdan: The Basic Script
        
        ►Shorok Alaa: Standard Calculations      

     	" 25 80 --yes-button "Back" --no-button "Exit")
        then
	documentation
        else
	if (NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Exit" --yesno "Do you really want to exit the calculator? 😢 " 10 70)
            then
            exit
            else
            authors
            fi
	fi
	

}


function calculations {

        calc=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Bash Calculator" --cancel-button "Back"  --menu "Choose the calculator type" 25 70 4 \
            "1" "Standard" \
            "2" "Bitwise" \
            "3" "Programmer" \
            3>&1 1>&2 2>&3)
        ######check the user choice of it was cancel or not###################
        if [ -z "$calc" ]  ###### the user choice was "back"
        then
        MainMenu
        else              
        case $calc in
        1)
            arithmeticmenu
            ;;
        2)
            bitwise
            ;;
	3)
            programmer
            ;;
	esac
        fi
}

##########################################################################
######################### arithmitic function ############################

function arithmeticmenu {

#for printing info msgs
function printMessage {

NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Message" --msgbox "$1" 8 70

}



#factorial
function f {

fact=1
num=$1
while [ $num -gt 1 ]
do
  fact=$((fact * num))
  num=$((num - 1))
done

echo $fact


}


function menu {


CHOICE=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Arithmetic" --cancel-button "Back"  --menu "Arithmetic" 25 70 16 \
  "1" "Addition" \
  "2" "Substraction" \
  "3" "Division" \
  "4" "Multiplication" \
  "5" "Power" \
  "6" "Factorial" 3>&1 1>&2 2>&3)

if [ -z "$CHOICE" ]; then

	calculations
else

  case $CHOICE in

	1)
		progress
		num1=$( input "First" "Addition ➕" )
		while [ $num1 == "s" ]
		do
			printMessage "Enter Numbers Only!"
			num1=""
			num1=$( input "First" "Addition ➕" )
		done
		num2=$( input "Second" "Addition ➕" )
		while [ $num2 == "s" ]
                do
                        printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second" "Addition ➕" )
                done
		res=$(bc<<<"scale=2;$num1+$num2")
		result "$num1" "+" "$num2" "$res"
		;;
	2)
		progress
		num1=$( input "First" "Subtraction ➖" )
                while [ $num1 == "s" ]
                do
                        printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "Subtraction ➖" )
                done
                num2=$( input "Second" "Subtraction ➖" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second" "Subtraction ➖" )
                done

		let "res=$num1-$num2"
		result "$num1" "-" "$num2" "$res"
		;;
	3)

		progress
		num1=$( input "First" "Division ➗" )
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "Division ➗" )
                done

                num2=$( input "Second" "Division ➗" )
		
                while [ $num2 == "s" ]
                do
                        printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second" "Division ➗" )
                done

		while [ "$num2" == 0 ]
		do
			printMessage "Can't divide by zero!"
			num2=$( input "Seconde" "Division ➗" )
			
		done
		res=$(bc -l<<<"scale=2;$num1/$num2")
		result "$num1" "/" "$num2" "$res"

		;;
	4)
		progress
		num1=$( input "First" "Multiplication ✖️" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "Multiplication" )
                done

                num2=$( input "Second" "Multiplication ✖️" )
		while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second" "Multiplication" )
                done

		let "res=$num1*$num2"
		result "$num1" "*" "$num2" "$res"

		;;
	5)

		progress
		num1=$( input "First" "Power" )
		while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "Power" )
                done

                num2=$( input "Second" "Power" )
                while [ $num2 == "s" ]
                do
                        printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second" "Power" )
                done

		let "res=$num1**$num2"
		result "$num1" "**" "$num2" "$res"

		;;
	6)
		progress
		num=$( input "" "Factorial " )
                while [ $num == "s" ]
                do
                        printMessage "Enter Numbers Only!"
                        num=""
                        num=$( input "First" "Factorial" )
                done

		n=$num
		#f "$num"
		res=$( f "$num" )
		#res=$?
		#echo $res
		printMessage "Factorial of $n Is $res"

  esac

fi

}
menu
}

## progress gauge
function progress {

{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 0.1
        echo $i
    done
} | NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --gauge "Please wait ...⏳" 6 50 0

}


function input {

n=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --inputbox --nocancel "Enter The $1 Number" 8 39  --title "$2 Operation"  "" 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ];
then
	if [[ $n =~ ^[0-9]*$ ]];
	then
    		echo $n
	else
		echo "s"
	fi
fi


}



# result function takes the 2 numbers ,the operand , and thier result and prints the
# out put in the form of a + b = c

function result {
dialog --title "✨ Result" --colors --msgbox "$1 $2 $3 = \Zb\Z1 $4 \Zn" 8  68  ; clear
menu 
}


#main Calling

#stop=0
#while [ $stop == "0" ]
#do

#	menu
#	if [ "$?" -eq "255" ]
#	then
#		continue
#

#	fi

#done


################### end of arithmeticmenu ###################################        

#######################################################################
######################### Bitwise calculations #####################

function bitwise {

ch=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Bitwise Calulator" --cancel-button "Back"  --menu "Select an option" 25 70 6 \
 "1" "Right shift" \
 "2" "Left Shift" \
 "3" "AND" \
 "4" "OR" \
 "5" "XOR" \
 "6" "NOT" \
 3>&1 1>&2 2>&3)

if [ -z "$ch" ] 
then
        calculations
else

case $ch in
	1)
		progress
		num1=$( input "First" "RIGHT  SHIFT ⏩" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "RIGHT  SHIFT ⏩" )
                done
		num2=$( input "Second" "RIGHT  SHIFT ⏩" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second " "RIGHT  SHIFT ⏩" )
                done
		
                message=$echo"✨ Result of $num1 [RIGHT  SHIFT] $num2 = $(( num1 >> num2 )) "
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Shift Right BitWise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;

        2)
          	progress
		num1=$( input "First" "LEFT  SHIFT ⏪" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "LEFT  SHIFT ⏪" )
                done
		num2=$( input "Second" "LEFT  SHIFT ⏪" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second " "LEFT  SHIFT ⏪" )
                done
		message=$echo"✨ Result of $num1 [LEFT  SHIFT] $num2 = $(( num1 << num2 ))" 
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Shift Left Bitwise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;

        3)
          	progress
		num1=$( input "First" "AND" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "AND" )
                done
		num2=$( input "Second" "AND" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second " "AND" )
                done
                message=$echo"✨ Result of $num1 [AND] $num2 = $(( num1 & num2 )) "
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "AND Bitwise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;

        4)
          	progress
		num1=$( input "First" "OR" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "OR" )
                done
		num2=$( input "Second" "OR" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second " "OR" )
                done
                message=$echo"✨ Result of $num1 [OR] $num2 = $(( num1 | num2 )) "
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "OR Bitwise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;
        5)
          	progress
		num1=$( input "First" "XOR" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "First" "XOR" )
                done
		num2=$( input "Second" "XOR" )
                while [ $num2 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num2=""
                        num2=$( input "Second " "XOR" )
                done
                message=$echo"✨ Result of $num1 [XOR] $num2 = $(( num1 ^ num2 ))"
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "XOR Bitwise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;
        6)
         	progress
		num1=$( input "" "NOT" )
		
                while [ $num1 == "s" ]
                do
                    	printMessage "Enter Numbers Only!"
                        num1=""
                        num1=$( input "" "NOT" )
                done

                message=$echo"✨ Result of [NOT] $num1 = $(( ~ num1 ))"
                if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "NOT Bitwise" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70)
                then
                bitwise
                else
                calculations
                fi

                ;;

       	esac
fi
}

################################# end of bitwise ####################################

###################################################################################
################################# programmer ######################################

function programmer {

OPTION=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --title "Programmer" --cancel-button "Back" --menu "Choose your option" 25 70 4 \
"1" "Binary" \
"2" "Decimal" \
"3" "Octal" \
"4" "Hexadecimal"   3>&1 1>&2 2>&3)

if [ -z "$OPTION" ]; ####### if the user choice was "back" it will back to caclculations types
then
    	calculations
else

NUMBER=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --inputbox "Please enter number :)" 25 70 3>&1 1>&2 2>&3)

if [ -z "$NUMBER" ]
then 
 
NUMBER=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --inputbox "Please enter a valid number :)" 25 70 3>&1 1>&2 2>&3)

case $OPTION in
        1)
if   [[ $NUMBER =~ [0-1]  ]];
then
                Decimal=$(echo "ibase=2;$NUMBER"|bc)
                Octal=$(echo "obase=8;ibase=2;$NUMBER"|bc)
                Hexadecimal=$(echo "obase=16;ibase=2;$NUMBER"|bc)

              message="✨ Conversion for [$NUMBER] :-

                        Decimal=$Decimal

                        Octal=$Octal

                        Hexadecimal=$Hexadecimal"
else
NUMBER=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --inputbox "Please enter 0 or 1 :)" 25 70 3>&1 1>&2 2>&3)
Decimal=$(echo "ibase=2;$NUMBER"|bc)
                Octal=$(echo "obase=8;ibase=2;$NUMBER"|bc)
                Hexadecimal=$(echo "obase=16;ibase=2;$NUMBER"|bc)

              message="✨ Conversion for [$NUMBER] :-

                        Decimal=$Decimal

                        Octal=$Octal

                        Hexadecimal=$Hexadecimal"


fi
if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;
2)

                Binary=$(echo "obase=2;$NUMBER"|bc)
                Octal=$(echo "obase=8;$NUMBER"|bc)
                Hexadecimal=$(echo "obase=16;$NUMBER"|bc)

              message="✨ Conversion for [$NUMBER] :-

                        Binary=$Binary

                        Octal=$Octal

                        Hexadecimal=$Hexadecimal"

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;
3)

Binary=$(echo "ibase=8;obase=2;$NUMBER"|bc)
Decimal=$(echo "ibase=8;$NUMBER"|bc)
Hexadecimal=$(echo "obase=16;ibase=8;$NUMBER"|bc)

       message="✨ Conversion for [$NUMBER] :-

		 Binary=$Binary

		 Decimal=$Decimal

		 Hexadecimal=$Hexadecimal"

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;

4)

Binary=$(echo "obase=2;ibase=16;$NUMBER"|bc)
Decimal=$(echo "ibase=16;$NUMBER"|bc)
Octal=$(echo "obase=8;ibase=16;$NUMBER"|bc)


message="✨ Conversion for [$NUMBER] :-

         Binary=$Binary

         Decimal=$Decimal
         
         Octal=$Octal"


esac
else

case $OPTION in
        1)

                if   [[ $NUMBER =~ [0-1]  ]];
then
                Decimal=$(echo "ibase=2;$NUMBER"|bc)
                Octal=$(echo "obase=8;ibase=2;$NUMBER"|bc)
                Hexadecimal=$(echo "obase=16;ibase=2;$NUMBER"|bc)

              message="✨ Conversion for [$NUMBER] :-

                        Decimal=$Decimal

                        Octal=$Octal

                        Hexadecimal=$Hexadecimal"
else
NUMBER=$(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail --inputbox "Please enter 0 or 1 :)" 25 70 3>&1 1>&2 2>&3)
Decimal=$(echo "ibase=2;$NUMBER"|bc)
                Octal=$(echo "obase=8;ibase=2;$NUMBER"|bc)
                Hexadecimal=$(echo "obase=16;ibase=2;$NUMBER"|bc)

              message="✨ Conversion for [$NUMBER] :-

                        Decimal=$Decimal

                        Octal=$Octal

                        Hexadecimal=$Hexadecimal"


fi

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;
2)

Binary=$(echo "obase=2;$NUMBER"|bc)
Octal=$(echo "obase=8;$NUMBER"|bc)
Hexadecimal=$(echo "obase=16;$NUMBER"|bc)

       message="✨ Conversion for [$NUMBER] :-

		 Binary=$Binary

		 Octal=$Octal

		 Hexadecimal=$Hexadecimal"

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;
3)

Binary=$(echo "ibase=8;obase=2;$NUMBER"|bc)
Decimal=$(echo "ibase=8;$NUMBER"|bc)
Hexadecimal=$(echo "obase=16;ibase=8;$NUMBER"|bc)

       message="✨ Conversion for [$NUMBER] :-

		 Binary=$Binary

		 Decimal=$Decimal

		 Hexadecimal=$Hexadecimal"

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;

4)

Binary=$(echo "obase=2;ibase=16;$NUMBER"|bc)
Decimal=$(echo "ibase=16;$NUMBER"|bc)
Octal=$(echo "obase=8;ibase=16;$NUMBER"|bc)


       message="✨ Conversion for [$NUMBER] :-

		 Binary=$Binary

		 Decimal=$Decimal
		 
		 Octal=$Octal"

if(NEWT_COLORS="${newtcols[@]} ${newtcols_error[@]}" whiptail  --title "Decimal convert" --yesno "$message" --yes-button "Done" --no-button "Back" 25 70);
then
programmer
else
calculations
fi
;;

esac
fi
fi

}


MainMenu
