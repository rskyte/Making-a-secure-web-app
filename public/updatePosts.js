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

function postPost() {
  var text = document.getElementById("postinfo").value

  document.getElementById("postinfo").value = ""
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "/posts", true);
  console.log(text)
  send = function() { 
    console.log("sending " + text)
    xhttp.send("post-content=" + text) 
  };
  setTimeout( send(), 500);
  loadPosts(displayPosts)
}

setInterval(function(){loadPosts(displayPosts)}, 2500)
