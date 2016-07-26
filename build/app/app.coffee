$( document ).ready () ->
        resetCounter = false

        stopCounter = false

        # Проверяем hash, открываем соответствующую страницу.

        checkHash = () ->
          console.log window.location.hash.substring(1)
          pageSelector = "." + window.location.hash.substring(1) + "-page"
          menuSelector = ".menu-" + window.location.hash.substring(1)
          $(menuSelector).addClass("active").siblings().removeClass("active")
          $(pageSelector).removeClass("hidden").siblings("main").addClass "hidden"
          stopCounter = true if window.location.hash isnt "#main"
          # Мобильный слайдер
          if window.location.hash is "#team"
            swiper = Swiper '.swiper-container',  {
                                                    initialSlide: 2
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
                                                  }
          $(".brain-piece").addClass "hidden"

        if !window.location.hash
          window.location.hash = "main"

        checkHash()

        window.addEventListener 'hashchange', () ->
          if window.location.hash.substring(1) is "admin"
            return $(".authorization").show()
          else
            $(".authorization").hide()

        # Запускаем карту Яндекс

        if document.location.pathname is "/happ" or document.location.pathname is "/contacts.html"
          mapInit = () ->
            if document.documentElement.clientWidth <= 768
              map = new ymaps.Map("map", {center: [55.73826304, 37.62920962], zoom: 16, controls:[]})
            else
              map = new ymaps.Map("map", {center: [55.73995728, 37.63342876], zoom: 16, controls:[]})
            hcPlacemark = new ymaps.Placemark [55.738845, 37.629017], {content: 'Human Control', balloonContent: 'Старый Толмачёвский переулок, 17с1'}, {iconLayout: 'default#image', iconImageHref: 'img/marker.png'}
            map.geoObjects.add hcPlacemark

          ymaps.ready mapInit

        # Делаем меню видимым для любой страницы, кроме главной

        if window.location.hash isnt "#main"
          $(".header-menu").removeClass "hidden"
        else
          $(".header-menu").addClass "main-page-menu"

        # По клику на розовый мозг выводим меню, делаем мозг серым

        $(".clickable-brain-pink").on "click", (e) =>
          stopCounter = true
          e.preventDefault()
          $(".main-page-menu").removeClass("hidden").animate {top: "135px"}, 500
          $(".mobile-menu").addClass "open"
          $(".brain-pink").addClass("hidden")
          $(".brain-gray").removeClass("hidden")

        # Обратный отсчёт

        # Перезапуск обратного отсчёта по движению мыши.

        $("body").on "mousemove", () ->
          return if stopCounter
          if !resetCounter
            resetCounter = true
            $(".current-count").html(7)
            countdown(7)

        # Функция обратного отсчёта

        countdown = (i) ->
          setTimeout () ->
            return if stopCounter
            if resetCounter is true
              resetCounter = false
              return
            --i
            $(".current-count").html(i)
            if i > 0
              countdown(i)
            else explodeBrain()
          , 1000

        # Запуск обратного отсчёта

        countdown(7)

        # Взрыв мозга

        explodeBrain = () =>
          $(".white-screen").removeClass("hidden").animate {opacity: 1}, 500
          setTimeout () ->
            $(".brain-pink").addClass("hidden")
            $(".brain-gray").removeClass("hidden")
            $(".main-page").addClass "hidden"
            $(".contacts-page").removeClass "hidden"
            window.location.hash = "contacts"
            $(".white-screen").animate {opacity: 0}, 500, () ->
              $(".white-screen").addClass "hidden"
            $(".header-menu").removeClass("hidden").removeClass "main-page-menu"
            $(".brain-piece").removeClass "hidden"
          , 500
          $(".brain-piece4").animate {top: "100%"}, 150000
          $(".brain-piece6").animate {top: "100%"}, 100000

        # Меню

        # Переход по ссылкам

        $(".menu-main").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "main"
          $(".brain-pink").addClass("hidden")
          $(".brain-gray").removeClass("hidden")
          checkHash()
        $(".menu-branding").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "branding"
          checkHash()
        $(".menu-creative").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "creative"
          checkHash()
        $(".menu-reengineering").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "reengineering"
          checkHash()
        $(".menu-marketing").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "marketing"
          checkHash()
        $(".menu-team").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "team"
          checkHash()
        $(".menu-contacts").on "click", (e) ->
          e.preventDefault()
          window.location.hash = "contacts"
          checkHash()

        # Подсветка мозга

        $(".menu-branding").mouseenter () ->
          $(".hover-brain-branding").show().siblings(".brain").hide()
        $(".menu-branding").mouseleave () ->
          if stopCounter
            $(".hover-brain-branding").hide().siblings(".brain-gray").show()
          else
            $(".hover-brain-branding").hide().siblings(".brain-pink").show()
        
        $(".menu-creative").mouseenter () ->
          $(".hover-brain-creative").show().siblings(".brain").hide()
        $(".menu-creative").mouseleave () ->
          if stopCounter
            $(".hover-brain-creative").hide().siblings(".brain-gray").show()
          else
            $(".hover-brain-creative").hide().siblings(".brain-pink").show()

        $(".menu-reengineering").mouseenter () ->
          $(".hover-brain-reengineering").show().siblings(".brain").hide()
        $(".menu-reengineering").mouseleave () ->
          if stopCounter
            $(".hover-brain-reengineering").hide().siblings(".brain-gray").show()
          else
            $(".hover-brain-reengineering").hide().siblings(".brain-pink").show()

        $(".menu-marketing").mouseenter () ->
          $(".hover-brain-marketing").show().siblings(".brain").hide()
        $(".menu-marketing").mouseleave () ->
          if stopCounter
            $(".hover-brain-marketing").hide().siblings(".brain-gray").show()
          else
            $(".hover-brain-marketing").hide().siblings(".brain-pink").show()

        # Мобильное меню

        $(".mobile-menu-button").find("span").on "click", () ->
          if $(".mobile-menu").hasClass "open"
            $(".mobile-menu").removeClass "open"
          else
            $(".mobile-menu").addClass "open"

        # Пульсация мозга

        brainPulse = () ->
          if document.documentElement.clientWidth > 768
            $(".brain-pink").animate( {width: "700px", left: "-5px", bottom: "-20px"}, 700).animate( {width: "690px", left: "0px", bottom: "-15px"}, 700)
          else if document.documentElement.clientWidth > 480
            $(".brain-pink").animate( {width: "410px", left: "-3px", bottom: "-16px"}, 700).animate( {width: "400px", left: "0px", bottom: "-15px"}, 700)
          else
            $(".brain-pink").animate( {width: "305px", left: "-2px", bottom: "-16px"}, 700).animate( {width: "300px", left: "0px", bottom: "-15px"}, 700)
          setTimeout () ->
            brainPulse()
          , 1400

        brainPulse()

        # Авторизация

        $('.login').on 'click',  (e) ->
          e.preventDefault()
          $.ajax {
            type: 'POST',
            url: '/ajax-login',
            data: $('e.target').closest("form").serialize(),
            success: (data) ->
              document.location.href = window.location.origin + '/admin'
            error: (error) ->
              if error.status is 401
                $(".login-alert").text "Неверно!"
            dataType: 'JSON'
          }

        # Отправка формы контактов

        $('.submit').on 'click',  (e) ->
          e.preventDefault()
          $.ajax {
            type: 'POST',
            url: '/request',
            data: $('e.target').closest("form").serialize(),
            success: (data) ->
              $('e.target').siblings("h1").text "Ваше сообщение успешно отправлено!"
            error: (error) ->
              $('e.target').siblings("h1").text "Сообщение не отправлено"
            dataType: 'JSON'
          }