function loadPosts(callback) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      callback(this.responseText);
    }
  };
  xhttp.open("GET", "/allposts", true);
  xhttp.send();
}

displayPosts = function(data){
  posts =JSON.parse(data);
  postArr = posts.map(function(post){
  	return "<p id='post-container' class='post-container'>" +
       "<b style='color:red'>" + post.user + ": </b>" +
        post.content  +
    	"</p>"
  })
  document.getElementById("feed-container").innerHTML = postArr.reverse().join("")
}

function postPost(){
  console.log('postPost')
  var text;
  var userId;
  while(!text || !userId) {
    text = document.getElementById("postinfo").value
    var userCookie = document.cookie.split("; ")[0]
    userId = userCookie.split("=")[1];
    if(text == "") { break }
  }
  console.log(userId)
  console.log(text)
  document.getElementById("postinfo").value = ""
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "/posts", true);
  xhttp.send("user-id=" + userId + "&post-content=" + text);
  loadPosts(displayPosts)
}

setInterval(function(){loadPosts(displayPosts)}, 2500)
