module = angular.module 'app', ['yandexMap', 'problemSqr', 'choiceSelect']


module.controller 'main',
  ['$rootScope', '$scope','$http', '$location', '$timeout', '$log'
   (($rootScope, $scope, $http, $location, $timeout, $log) ->

     $scope.modal =
       isShown: false

     # ---- Send request
     $scope.request=
       name: null
       phone: null
       send: (->
         $scope.modal.isShown = false
         $.ajax(
           method: 'POST'
           url:  "https://mandrillapp.com/api/1.0/messages/send.json"
           data:
             key: 'XrhYSIo5ZAQ6Dcbp5ItPDA'
             message:
               subject: 'Заявка с сайта kinevskaya.ru'
               html: '<h2>Заявка с сайта kinevskaya.ru</h2><ul><li>' + $scope.request.name + '</li><li>' + $scope.request.phone + '</li></ul>'
               text: 'Имя: ' + $scope.request.name + ', тел.: ' + $scope.request.phone
               from_email: 'info@kinevskaya.ru'
               to: [
                 email : 'petma17@gmail.com'
                 name: 'Maria'
                 type: 'to'
               ,
                 email : 'pepelazz00@gmail.com'
                 name: 'admin'
                 type: 'to'
               ]
         )
         .done ((data)->
           $log.info data
           return)
         .fail (->
           $log.error 'server not respond'
           return)
         $scope.request.name = null
         $scope.request.phone = null

         return false)

     $scope.getContent =(->
       $.ajax(
         method: 'POST'
         url:  "https://mandrillapp.com/api/1.0/messages/content.json"
         data:
           key: 'XrhYSIo5ZAQ6Dcbp5ItPDA'
           id: 'a5747fc40c334736933c17ac8c9dffc6'
       )
       .done ((data)->
         $log.info data
         return)
       .fail (->
         $log.error 'server not respond'
         return)
       return)

     return)]



