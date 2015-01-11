module = angular.module 'choiceSelect', []

module.controller 'choiceSelect',
  ['$rootScope', '$scope'
   (($rootScope, $scope) ->
      $scope.answer = 0
      $scope.choice =((index)->
        if($scope.answer == index)
          $scope.answer = 0
        else
          $scope.answer = index
        return)
      return)]
