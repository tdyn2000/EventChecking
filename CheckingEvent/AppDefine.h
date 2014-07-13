//
//  AppDefine.h
//  CheckingEvent
//
//  Created by ADMIN on 7/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

//app message
#define msg_connection_error @"Connection error"
#define msg_confirm @"Are you sure you want to log out?"
#define msg_invalid   @"INVALID"
#define msg_valid   @"VALID"

//app queue
#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//app URL
#define loginUrl @"http://sss-mobile-test.herokuapp.com/login"
#define scanUrl @"http://sss-mobile-test.herokuapp.com/scan"

//enum
#define  code_unauthorized -1011

//login json key
#define k_id @"id"
#define k_username @"username"
#define k_email @"email"
#define k_access_token @"access_token"
#define k_login @"login"

#define k_code @"code"

#define k_error @"error"
#define k_message @"message"

//constant
#define limit 5

//enum define
typedef enum {
    AppDriverAdsType = 0,
    CARewardAdsType,
    GmoAdsType,
    GreeRewardAdsType
} adsType;
