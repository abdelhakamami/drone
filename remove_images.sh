UNAME="abdelhakavaxia"
TOKEN="dckr_pat_nmj1n6g5nQF07n7w5VHVaYsanTI"
echo "$UNAME"
echo "$TOKEN"
tag=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/election-app-front-end/tags/?page_size=100 | jq -r '.results|.[]|.name'| head  )
echo "$tag"
num_tags=$(echo "$tag" | wc -l)
echo "$num_tags"
if [ $num_tags -gt 2 ] 
then
most_recent_tags=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/election-app-front-end/tags/?page_size=100 | jq -r '.results|.[]|.name'| head -n 2)
echo "$most_recent_tags"
nbrtagsupp=$((${num_tags} - 2))
echo "$nbrtagsupp"
tagsupp=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/election-app-front-end/tags/?page_size=100 | jq -r '.results|.[]|.name'| tail -n ${nbrtagsupp})
echo "$tagsupp"
fi
for j in ${tagsupp}  
  do 
    docker run --rm  lumir/remove-dockerhub-tag --user ${UNAME}  --password ${TOKEN}   abdelhakavaxia/election-app-front-end/:${j} -v /var/run/docker.sock:/var/run/docker.sock  ; 
  done

