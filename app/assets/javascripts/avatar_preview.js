$(document).on("turbolinks:load",function(){

  $("#user_avatar").change(function(){
    if(!this.files.length){
      return;
    };
    var file = this.files[0],
        $img = $(this).siblings("img");
    upload(file, $img);
  });

  function upload(file, $img) {
    var reader = new FileReader();
    reader.onload = function(event) {
      $img.attr("src", event.target.result);
    };
    reader.readAsDataURL(file);
  };
});
