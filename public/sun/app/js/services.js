'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
var myapp = angular.module('myApp.services', []);

myapp.value('version', '0.1');

myapp.factory('freelancer', function() {
    var factory = {};
    factory.APIlist = [
    {'group' : 'User', 'name' : 'getUsersBySearch'},
    {'group' : 'User', 'name' : 'getUserFeedback'},
    {'group' : 'User', 'name' : 'getUserDetails'},
    {'group' : 'Job', 'name' : 'getJobList'},
    {'group' : 'Job', 'name' : 'getCategoryJobList'},
    {'group' : 'Job', 'name' : 'getMyJobList'},
    {'group' : 'Profile', 'name' : 'getAccountDetails'},
    {'group' : 'Profile', 'name' : 'getProfileInfo'},
    {'group' : 'Profile', 'name' : 'setProfileInfo'},
    {'group' : 'Employer', 'name' : 'postNewProject'},
    {'group' : 'Employer', 'name' : 'postNewTrialProject'},
    {'group' : 'Employer', 'name' : 'postNewDraftProject'},
    {'group' : 'Employer', 'name' : 'chooseWinnerForProject'},
    {'group' : 'Employer', 'name' : 'getPostedProjectList'},
    {'group' : 'Employer', 'name' : 'inviteUserForProject'},
    {'group' : 'Employer', 'name' : 'updateProjectDetails'},
    {'group' : 'Employer', 'name' : 'eligibleForTrialProject'},
    {'group' : 'Employer', 'name' : 'publishDraftProject'},
    {'group' : 'Employer', 'name' : 'upgradeTrialProject'},
    {'group' : 'Employer', 'name' : 'deleteDraftProject'},
    {'group' : 'Freelancer', 'name' : 'getProjectListForPlacedBids'},
    {'group' : 'Freelancer', 'name' : 'placeBidOnProject'},
    {'group' : 'Freelancer', 'name' : 'retractBidFromProject'},
    {'group' : 'Freelancer', 'name' : 'acceptBidWon'},
    {'group' : 'Common', 'name' : 'requestCancelProject'},
    {'group' : 'Common', 'name' : 'postFeedback'},
    {'group' : 'Common', 'name' : 'postReplyForFeedback'},
    {'group' : 'Common', 'name' : 'requestWithdrawFeedback'},
    {'group' : 'Common', 'name' : 'getPendingFeedback'},
    {'group' : 'Common', 'name' : 'getConfigVersion'},
    {'group' : 'Common', 'name' : 'getTerms'},
    {'group' : 'Common', 'name' : 'getProjectBudgetOptions'},
    {'group' : 'Payment', 'name' : 'getAccountBalanceStatus'},
    {'group' : 'Payment', 'name' : 'getAccountTransactionList'},
    {'group' : 'Payment', 'name' : 'requestWithdrawal'},
    {'group' : 'Payment', 'name' : 'createMilestonePayment'},
    {'group' : 'Payment', 'name' : 'transferMoney'},
    {'group' : 'Payment', 'name' : 'requestCancelWithdrawal'},
    {'group' : 'Payment', 'name' : 'cancelMilestone'},
    {'group' : 'Payment', 'name' : 'getAccountMilestoneList'},
    {'group' : 'Payment', 'name' : 'getAccountWithdrawalList'},
    {'group' : 'Payment', 'name' : 'requestReleaseMilestone'},
    {'group' : 'Payment', 'name' : 'releaseMilestone'},
    {'group' : 'Payment', 'name' : 'getBalance'},
    {'group' : 'Payment', 'name' : 'prepareTransfer'},
    {'group' : 'Payment', 'name' : 'getWithdrawalFees'},
    {'group' : 'Payment', 'name' : 'getProjectListForTransfer'},
    {'group' : 'Notification', 'name' : 'getNotification'},
    {'group' : 'Notification', 'name' : 'getNews'},
    {'group' : 'Project', 'name' : 'searchProjects'},
    {'group' : 'Project', 'name' : 'getProjectFees'},
    {'group' : 'Project', 'name' : 'getProjectDetails'},
    {'group' : 'Project', 'name' : 'getBidsDetails'},
    {'group' : 'Project', 'name' : 'getPublicMessages'},
    {'group' : 'Project', 'name' : 'postPublicMessage'},
    {'group' : 'Project', 'name' : 'getProjectBudgetConfig'},
    {'group' : 'Message', 'name' : 'getInboxMessages'},
    {'group' : 'Message', 'name' : 'getSentMessages'},
    {'group' : 'Message', 'name' : 'getUnreadCount'},
    {'group' : 'Message', 'name' : 'sendMessage'},
    {'group' : 'Message', 'name' : 'markMessageAsRead'},
    {'group' : 'Message', 'name' : 'loadMessageThread'},
    ];
    return factory;
});

myapp.factory('odesk', function() {
    var factory = {};
    factory.APIlist = [
    { 'group' : 'Search jobs', 'name' : 'searchJobs'},
    { 'group' : 'search Providers', 'name' : 'searchProviders'},
    { 'group' : 'user Information', 'name' : 'userInformation'},
    { 'group' : 'Team', 'name' : 'getTeamRooms'},
    { 'group' : 'Jobs HR API', 'name' : 'getMyJobs'}

    ];
    return factory;
});

myapp.factory('rails_server', ['$http', function($http) {
    var factory = {};
    factory.development_server_host = 'http://0.0.0.0:3000';
    // factory.development_server_host = 'http://telwowrk.herokuapp.com';
    var url = factory.development_server_host;
    factory.ckeckLogin = function() {
        console.log("go isLogin");
        $http.get(url + "/angular/isLogin").success(function(data){
            if(data.isLogin == false)
                window.location.href = "http://www.google.com";
        });
    }
    return factory;
}]);
