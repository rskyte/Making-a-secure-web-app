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
  var text = document.getElementById("postinfo").value
  document.getElementById("postinfo").value = ""
  var xhttp = new XMLHttpRequest();
  xhttp.open("Post", "/posts", true);
  var cookieHash = {} 
  document.cookie.split("; ").forEach(function(cookie){
    const arr = cookie.split("=");
    cookieHash[arr[0]]= arr[1];
  })
  const id = cookieHash['user-id']
  xhttp.send("user-id="+id+"&post-content=" + text);
  loadPosts(displayPosts)
}

setInterval(function(){loadPosts(displayPosts)}, 2000)
