module = angular.module 'yandexMap', []

module.directive 'yandexMap', ['$rootScope'
  (($rootScope) ->
   restrict: 'A'
   link: ($scope, element, attrs) ->

     fixContentHeight =->
       width = $(window).width()
       $(element).css('height', 500).css('width', width)
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