#!/bin/sh

# add more args here according to preference
ARGS="--volume=30"
ARGS="--no-video"

notification(){
# change the icon to whatever you want. Make sure your notification server
# supports it and already configured.

# Now it will receive argument so the user can rename the radio title
# to whatever they want

	notify-send "Playing now: " "$@" --icon=media-tape
}

menu(){
	printf "1. Techno Radio\n"
	printf "2. Deep Techno Radio\n"
	printf "3. 90's Retro Radio\n"
	printf "4. Psytrance Radio\n"
	printf "5. Rebel Radio\n"
	printf "6. Japan Lofi\n"
	printf "7. Liquid DnB\n"
	printf "8. Jungle Lofi"
}

main() {
	choice=$(menu | rofi -dmenu | cut -d. -f1)

	case $choice in
		1)
			notification "Techno Radio ☕️🎶";
            URL="https://www.youtube.com/watch?v=sQpeIw3HFq8"
			break
			;;
		2)
			notification "Deep Techno Radio ☕️🎶";
            URL="https://www.youtube.com/watch?v=c6i70DSxhOo"
			break
			;;
		3)
			notification "90's Retro Radio ☕️🎶";
            URL="https://www.youtube.com/watch?v=1Ep2eiM5X9U"
			break
			;;
		4)
			notification "Psytrance Radio ☕️🎶";
            URL="https://www.youtube.com/watch?v=c6i70DSxhOo"
			break
			;;
		5)
			notification "Rebel Radio ☕️🎶";
            URL="https://www.youtube.com/watch?v=8VfeAShG1zo&list=RDQMwgYu5pYzRBY&start_radio=1"
			break
			;;
		6)
			notification "Japan Lofi ☕️🎶";
            URL="https://www.youtube.com/watch?v=JWlKA9wmO64"
			break
			;;
        7)
			notification "Liquid DnB ☕️🎶";
            URL="https://www.youtube.com/watch?v=8z1tLBynk7U"
			break
			;;
        8)
			notification "Jungle Lofi ☕️🎶";
            URL="https://www.youtube.com/watch?v=q4G8Hsqfsdw"
			break
			;;
	esac
    # run mpv with args and selected url
    # added title arg to make sure the pkill command kills only this instance of mpv
    mpv $ARGS --title="radio-mpv" $URL
}

pkill -f radio-mpv || main
