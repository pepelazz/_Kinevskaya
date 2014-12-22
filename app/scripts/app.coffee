module = angular.module 'app', []


module.controller 'main',
  ['$rootScope', '$scope','$http', '$location', '$timeout'
   (($rootScope, $scope, $http, $location, $timeout) ->

    fixFooter =(->
      if(($('header').height() + $('.main-area').height() + $('.footer').height()) < $(window).height())
        $('.footer').addClass('sticky')
      return)
    fixFooter()

    $(window).resize (->
      fixFooter()
      return)
    $rootScope.fixFooter = fixFooter

    $scope.modal =
      isShown: false

    return)]


module.directive 'yandexMap', ['$rootScope'
  (($rootScope) ->
    restrict: 'A'
    link: ($scope, element, attrs) ->

      fixContentHeight =->
        width = $(window).width()
        $(element).css('height', 500).css('width', width)
        $rootScope.fixFooter()
        return

      fixContentHeight()

      $(window).resize -> fixContentHeight(); return

      coord = $scope.$eval attrs.yandexMap

      init =(->
        myMap = new ymaps.Map("map",
          center: [coord.lat, coord.lon]
          zoom: 16
        )
        myMap.controls.add('zoomControl', { left: 5, top: 15 })
        myMap.balloon.open([coord.lat, coord.lon], coord.adr, {
          closeButton: false
        })

        return)

      ymaps.ready(init)

      return
  )]







