function cart(){

        cplaname = sessionStorage.getItem("planname");
        cplan = sessionStorage.getItem('plan');
        cplanamount = sessionStorage.getItem('planamount');
        cquantity = sessionStorage.getItem('quantity');

        if (cplanname && cplan && cplanamount && cquantity){
        

        $('#cplanname').text(cplaname);
        $('#cplan').text(cplan);
        $('#camount').text(cplanamount);
        $('#cquantity').text(cquantity);

    } else{
        $('#emptycart').css('display','block');
        $('#cart').css('display','none');
    }

    }
$(document).ready(function(){
    $(".navigation").parent().before("<a class='expandMenu'><i></i><i></i><i></i></a>");
    $(document).on("click",".expandMenu",function(){
        // $(this).toggleClass("open");
        $(".navigation").addClass("active");
        $("body").addClass("active");
    })

    $("span#close-icon").on("click",function(){
      $(".navigation").removeClass("active");
      $("body").removeClass("active");
    })

    $('.business-slider').slick({
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 1,
        dots:false,
        arrows:true,
        centerMode: true,
        centerPadding: '60px',
        responsive: [
            {
              breakpoint: 991,
              settings: {
                slidesToShow: 2,
              }
            },
            {
              breakpoint: 768,
              settings: {
                slidesToShow: 1,
                centerPadding: '0px'
              }
            }
        ]
    });

    $(".cart-wrapper").on("click","a",function(){
      cart();
       $(".shopping-cart-wrapper").toggleClass("active");
       $(".shopping-cart").toggleClass("active"); 
    })

    $(".close-btn").on("click",function(){
      $(this).parents(".shopping-cart-wrapper").removeClass("active");
      $(".shopping-cart").removeClass("active"); 
    })
})