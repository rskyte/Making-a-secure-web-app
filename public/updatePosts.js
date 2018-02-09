function loadPosts(callback) {
  console.log('called')
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      callback(this.responseText);
    }
  };
  xhttp.open("GET", "/allposts", true);
  xhttp.send();
}

postPosts = function(data){
  posts =JSON.parse(data);
  postArr = posts.map(function(post){
  	return "<p id='post-container' class='post-container'>" +
       "<b style='color:red'>" + post.user + ": </b>" +
        post.content  +
    	"</p>"
  })
  document.getElementById("feed-container").innerHTML = postArr.reverse().join("")
}

setInterval(function(){loadPosts(postPosts)}, 2000)
