angular.module('Articles', []);

angular.module('Articles').controller('UsersController', ['$scope', '$http', '$timeout',
function($scope, $http, $timeout) {
  setAngularCSRFToken($http);

  // *********************************Private functions***********************************************

  // *********************************Public functions***********************************************
  $scope.signUP = function(){
    $http({
      method: "POST",
      url: "/sign_up",
      data: $scope.userRegistrationForm
    }).success(function(response){
      $scope.success_message = response.message;
      console.log(response.message);
      $scope.userRegistrationForm = angular.copy(userForm);
    }).error(function(){
      $scope.userRegistrationForm = angular.copy(userForm);
      $scope.error_message = "Something went wrong with the server";
    });
  };

  $scope.usersLogin = function(){
    console.log("login");
    $http({
      method: "GET",
      url: "/login",
      params: $scope.userLogin
    }).success(function(response){
      if (response.message == "admin"){
        $scope.is_admin = true;
      }else {
        $scope.is_admin = false;
      }
    }).error(function(){
      $scope.error_message = "Something went wrong with the server";
    });
  };


  // *********************************Initialization Code***********************************************
  var response = $('.js_articles_container').data('content');
  $scope.success_message = response.message;

  $scope.genders = ['Male','Female'];

  var userForm ={
    name: null,
    email: null,
    gender: null,
    mobile: null,
    password: null
  };

  $scope.userLogin = {
    email: null,
    password: null
  };

  $scope.userRegistrationForm = angular.copy(userForm);


}]);
