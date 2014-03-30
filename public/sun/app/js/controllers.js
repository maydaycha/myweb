'use strict';

/* Controllers */

angular.module('myApp.controllers', [])
.controller('indexController', ['$scope', function($scope){
    // $scope.system_list = [{ 'name' : 'freelancer'}, {'name' : 'odesk'}];
    $scope.system_list = ['freelancer', 'odesk'];
    $scope.systemSelected = $scope.system_list[0];
    $scope.changeSystem = function() {
        window.location.href = "#"+$scope.systemSelected+"API";
    }
}])
.controller('FreelancerController', ['$scope', '$http', 'freelancer', function($scope, $http, freelancer) {
    console.log(freelancer.APIlist);
    $scope.apiList = freelancer.APIlist;

    $scope.getAIP = function() {

        /* jsonp request, this fix cross domain request issue */
        $scope.requestUrl = 'http://127.0.0.1:8000/freelancer/'+$scope.api.name+'/?callback=JSON_CALLBACK';
        $http.jsonp($scope.requestUrl).success(function(data){
            console.log(data);
            $scope.dataArray = [];
            $scope.data = data["json-result"];
            $scope.obj = {};
            for(var key in $scope.data) {
                if( typeof $scope.data[key] != 'undefined') {
                    $scope.obj = { 'meta' : key, 'data' : $scope.data[key]};
                    $scope.dataArray.push($scope.obj);
                }
            }
            console.log($scope.dataArray);
        });
    }


    $scope.seeHeader = function() {
       $scope.requestUrl = 'http://127.0.0.1:8000/freelancer/seeMeta';
       $http({
        url : $scope.requestUrl,
        method : "GET",
        headers: {'Content-type': 'application/x-www-form-urlencoded'},
        withCredentials: true
    }).success(function(data){
        console.log(data);
    }).error(function(status){
        console.log(status);
    });
}

$scope.login = function(data){
    $scope.requestUrl = 'http://127.0.0.1:8000/freelancer/login/';
    window.location.href = $scope.requestUrl;
}
}])
.controller('OdeskController', ['$scope', 'odesk', '$http', function($scope, odesk, $http) {
    $scope.apiList = odesk.APIlist;
    $scope.getAIP = function() {
        /* jsonp request, this fix cross domain request issue */
        $scope.requestUrl = 'http://127.0.0.1:8000/odesk/'+$scope.api.name+'/?callback=JSON_CALLBACK';
        console.log($scope.requestUrl);
        $http.jsonp($scope.requestUrl).success(function(data){
            console.log(data);
            $scope.dataObj = data;
            $scope.dataArray = [];
            $scope.data = data["jobs"];
            $scope.obj = {};
            for(var key in $scope.data) {
                if( typeof $scope.data[key] != 'undefined') {
                    $scope.obj = { 'meta' : key, 'data' : $scope.data[key]};
                    $scope.dataArray.push($scope.obj);
                }
            }
            console.log($scope.dataArray);
        });
    }
}])
.controller('projectsController', ['$scope', '$http', function($scope, $http){
    $scope.jsonp = function() {
        alert("HI");
        $http.jsonp('http://0.0.0.0:3000/angular?callback=JSON_CALLBACK').success(function(data) {
          console.log(data);
      });
    }


}]);
