$( document ).ready(function() {
  var brainPulse, checkHash, countdown, explodeBrain, mapInit, resetCounter, stopCounter;

  resetCounter = false;

  stopCounter = false;

  checkHash = function() {
    var menuSelector, pageSelector, swiper;
    pageSelector = "." + window.location.hash.substring(1) + "-page";
    menuSelector = ".menu-" + window.location.hash.substring(1);
    $(menuSelector).addClass("active").siblings().removeClass("active");
    $(pageSelector).removeClass("hidden").siblings("main").addClass("hidden");
    if (window.location.hash !== "#main") {
      stopCounter = true;
    }
    if (window.location.hash === "#team") {
      swiper = Swiper('.swiper-container', {
        initialSlide: 2,
        pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 30,
        fade: {
          crossFade: false
        },
        parallax: true,
        loop: true
      });
    }
    return $(".brain-piece").addClass("hidden");
  };

  if (!window.location.hash) {
    window.location.hash = "main";
  }

  checkHash();

  window.addEventListener('hashchange', function() {
    if (window.location.hash.substring(1) === "admin") {
      return $(".authorization").show();
    } else {
      return $(".authorization").hide();
    }
  });

  if (document.location.pathname === "/app" || document.location.pathname === "/contacts.html") {
    mapInit = function() {
      var hcPlacemark, map;
      if (document.documentElement.clientWidth <= 768) {
        map = new ymaps.Map("map", {
          center: [55.73826304, 37.62920962],
          zoom: 16,
          controls: []
        });
      } else {
        map = new ymaps.Map("map", {
          center: [55.73995728, 37.63342876],
          zoom: 16,
          controls: []
        });
      }
      hcPlacemark = new ymaps.Placemark([55.738845, 37.629017], {
        content: 'Human Control',
        balloonContent: 'Старый Толмачёвский переулок, 17с1'
      }, {
        iconLayout: 'default#image',
        iconImageHref: 'img/marker.png'
      });
      return map.geoObjects.add(hcPlacemark);
    };
    ymaps.ready(mapInit);
  }

  if (window.location.hash !== "#main") {
    $(".header-menu").removeClass("hidden");
  } else {
    $(".header-menu").addClass("main-page-menu");
  }

  $(".clickable-brain-pink").on("click", (function(_this) {
    return function(e) {
      stopCounter = true;
      e.preventDefault();
      $(".main-page-menu").removeClass("hidden").animate({
        top: "135px"
      }, 500);
      $(".mobile-menu").addClass("open");
      $(".brain-pink").addClass("hidden");
      return $(".brain-gray").removeClass("hidden");
    };
  })(this));

  $("body").on("mousemove", function() {
    if (stopCounter) {
      return;
    }
    if (!resetCounter) {
      resetCounter = true;
      $(".current-count").html(7);
      return countdown(7);
    }
  });

  countdown = function(i) {
    return setTimeout(function() {
      if (stopCounter) {
        return;
      }
      if (resetCounter === true) {
        resetCounter = false;
        return;
      }
      --i;
      $(".current-count").html(i);
      if (i > 0) {
        return countdown(i);
      } else {
        return explodeBrain();
      }
    }, 1000);
  };

  countdown(7);

  explodeBrain = (function(_this) {
    return function() {
      $(".white-screen").removeClass("hidden").animate({
        opacity: 1
      }, 500);
      setTimeout(function() {
        $(".brain-pink").addClass("hidden");
        $(".brain-gray").removeClass("hidden");
        $(".main-page").addClass("hidden");
        $(".contacts-page").removeClass("hidden");
        window.location.hash = "contacts";
        $(".white-screen").animate({
          opacity: 0
        }, 500, function() {
          return $(".white-screen").addClass("hidden");
        });
        $(".header-menu").removeClass("hidden").removeClass("main-page-menu");
        return $(".brain-piece").removeClass("hidden");
      }, 500);
      $(".brain-piece4").animate({
        top: "100%"
      }, 150000);
      return $(".brain-piece6").animate({
        top: "100%"
      }, 100000);
    };
  })(this);

  $(".menu-main").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "main";
    $(".brain-pink").addClass("hidden");
    $(".brain-gray").removeClass("hidden");
    return checkHash();
  });

  $(".menu-branding").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "branding";
    return checkHash();
  });

  $(".menu-creative").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "creative";
    return checkHash();
  });

  $(".menu-reengineering").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "reengineering";
    return checkHash();
  });

  $(".menu-marketing").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "marketing";
    return checkHash();
  });

  $(".menu-team").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "team";
    return checkHash();
  });

  $(".menu-contacts").on("click", function(e) {
    e.preventDefault();
    window.location.hash = "contacts";
    return checkHash();
  });

  $(".menu-branding").mouseenter(function() {
    return $(".hover-brain-branding").show().siblings(".brain").hide();
  });

  $(".menu-branding").mouseleave(function() {
    if (stopCounter) {
      return $(".hover-brain-branding").hide().siblings(".brain-gray").show();
    } else {
      return $(".hover-brain-branding").hide().siblings(".brain-pink").show();
    }
  });

  $(".menu-creative").mouseenter(function() {
    return $(".hover-brain-creative").show().siblings(".brain").hide();
  });

  $(".menu-creative").mouseleave(function() {
    if (stopCounter) {
      return $(".hover-brain-creative").hide().siblings(".brain-gray").show();
    } else {
      return $(".hover-brain-creative").hide().siblings(".brain-pink").show();
    }
  });

  $(".menu-reengineering").mouseenter(function() {
    return $(".hover-brain-reengineering").show().siblings(".brain").hide();
  });

  $(".menu-reengineering").mouseleave(function() {
    if (stopCounter) {
      return $(".hover-brain-reengineering").hide().siblings(".brain-gray").show();
    } else {
      return $(".hover-brain-reengineering").hide().siblings(".brain-pink").show();
    }
  });

  $(".menu-marketing").mouseenter(function() {
    return $(".hover-brain-marketing").show().siblings(".brain").hide();
  });

  $(".menu-marketing").mouseleave(function() {
    if (stopCounter) {
      return $(".hover-brain-marketing").hide().siblings(".brain-gray").show();
    } else {
      return $(".hover-brain-marketing").hide().siblings(".brain-pink").show();
    }
  });

  $(".mobile-menu-button").find("span").on("click", function() {
    if ($(".mobile-menu").hasClass("open")) {
      return $(".mobile-menu").removeClass("open");
    } else {
      return $(".mobile-menu").addClass("open");
    }
  });

  brainPulse = function() {
    if (document.documentElement.clientWidth > 768) {
      $(".brain-pink").animate({
        width: "700px",
        left: "-5px",
        bottom: "-20px"
      }, 700).animate({
        width: "690px",
        left: "0px",
        bottom: "-15px"
      }, 700);
    } else if (document.documentElement.clientWidth > 480) {
      $(".brain-pink").animate({
        width: "410px",
        left: "-3px",
        bottom: "-16px"
      }, 700).animate({
        width: "400px",
        left: "0px",
        bottom: "-15px"
      }, 700);
    } else {
      $(".brain-pink").animate({
        width: "305px",
        left: "-2px",
        bottom: "-16px"
      }, 700).animate({
        width: "300px",
        left: "0px",
        bottom: "-15px"
      }, 700);
    }
    return setTimeout(function() {
      return brainPulse();
    }, 1400);
  };

  brainPulse();

  $('.login').on('click', function(e) {
    e.preventDefault();
    return $.ajax({
      type: 'POST',
      url: '/ajax-login',
      data: $('e.target').closest("form").serialize(),
      success: function(data) {
        return document.location.href = window.location.origin + '/admin';
      },
      error: function(error) {
        if (error.status === 401) {
          return $(".login-alert").text("Неверно!");
        }
      },
      dataType: 'JSON'
    });
  });

  $('.submit').on('click', function(e) {
    e.preventDefault();
    return $.ajax({
      type: 'POST',
      url: '/request',
      data: $('e.target').closest("form").serialize(),
      success: function(data) {
        return $('e.target').siblings("h1").text("Ваше сообщение успешно отправлено!");
      },
      error: function(error) {
        return $('e.target').siblings("h1").text("Сообщение не отправлено");
      },
      dataType: 'JSON'
    });
  });
});