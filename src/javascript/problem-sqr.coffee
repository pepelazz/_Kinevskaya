module = angular.module 'problemSqr', []

module.controller 'problemSqr',
  ['$rootScope', '$scope', '$location', '$timeout', '$log'
   (($rootScope, $scope, $location, $timeout, $log) ->

     $scope.problems =[
       name: 'work'
       coordIn: [1, 0]
       coordOut: [-1, -1]
       sign: 'работа'
       isSelected: false
       sections:['Синдром выгорания', 'Поиск призвания', 'Сложности в отношениях с партерами']
     ,
       name: 'emotions'
       coordIn: [-1, 0]
       coordOut: [1, -1]
       sign: 'эмоции'
       isSelected: false
     ,
       name: 'family'
       coordIn: [-1, -1]
       coordOut: [1, 1]
       sign: 'семья'
       isSelected: false
     ,
       name: 'health'
       coordIn: [1, -1]
       coordOut: [-1, 1]
       sign: 'здоровье'
       isSelected: false
     ]

     $scope.problemsSqr =
       state: 'zoomOut'
       zoomInProblem: (($index)->
         if($scope.problemsSqr.state == 'zoomOut')
           $scope.problemsSqr.state = 'zoomIn'
           $scope.problems[$index].isSelected = true
           $('#circle-bg').addClass('big')
           $("[id^='sign-']").addClass('hide')
           $(".problem-square > .wrapper").addClass('hide')
           $('#problem-title').snabbt(
             from_position: [-142.5, -33, 0]
             position: [-142.5, -340, 0]
             duration: 200
             easing: 'ease'
           )
         return)
       zoomOutProblem: (->
         $scope.problemsSqr.state = 'zoomOut'
         $('#circle-bg').removeClass('big')
         $(".problem-square > .wrapper").removeClass('hide')
         $('#back-to-problem').removeClass('show')
         $('#problem-title-detail').html("")
         $('#problem-title').snabbt(
           from_position: [-142.5, -340, 0]
           position: [-142.5, -33, 0]
           duration: 200
           easing: 'ease'
           callback: (()->
             setTimeout(()->
               $("[id^='sign-']").removeClass('hide')
               $('.problem-sections').removeClass('show')
             , 150)
           )
         )
         $scope.problems.forEach (item)->
           item.isSelected = false
         $scope.problemsSqr.selectedName = {}
         return)
       showArticle: ((problemIndex, articleIndex)->
         $scope.problemsSqr.selectedName =
           problem: problemIndex
           article: articleIndex
         return)
     selectedName: {}

     return)]

module.directive 'myShake',
  [(()->
    restrict: 'A'
    link: (($scope, element, attrs) ->
      element.on 'mouseenter', (()->
        if($scope.problemsSqr.state == 'zoomOut')
          snabbt(element,
            rotation: [0, 0, Math.PI/2],
            easing: 'spring',
            spring_constant: 1.9,
            spring_deacceleration: 0.9,
          ).then(
            rotation: [0, 0, 0],
          )
        return)
      return)
   )]

module.directive 'problemCircle',
  [(()->
    restrict: 'A'
    link: ($scope, element, attrs, container) ->
      model = $scope.problems[attrs.problemCircle]
      $scope.$watch 'problemsSqr.state', (newVal, oldVal)->
        if(newVal == oldVal)
          return
        if(newVal == 'zoomIn')
          if(model.isSelected)
            $(element).snabbt(
              position: [175 * model.coordIn[0], 350 * model.coordIn[1] , 0]
              duration: 300
              easing: 'ease'
              callback: (()->
                setTimeout(()->
                  $('#problem-title-detail').html(model.sign)
                  $('#back-to-problem').addClass('show')
                  $('.problem-sections').addClass('show')
                , 150)
                return)
            )
            model.currentPosition = [175 * model.coordIn[0], 350 * model.coordIn[1]]
          else
            $(element).snabbt(
              position: [500 * model.coordOut[0], 500 * model.coordOut[1] , 0]
              duration: 300
              delay: 200
              easing: 'ease'
            )
            model.currentPosition = [500 * model.coordOut[0], 500 * model.coordOut[1]]
        if(newVal == 'zoomOut')
          $(element).snabbt(
            from_position: [model.currentPosition[0], model.currentPosition[1], 0]
            position: [0, 0, 0]
            duration: 300
            delay: 200
            easing: 'ease-out'
          )
          model.currentPosition = [0, 0]

      return
   )]

