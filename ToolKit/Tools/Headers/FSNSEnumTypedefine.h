//
//  FSNSEnumTypedefine.h
//  Ready
//
//  Created by luyee on 2018/8/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#ifndef FSNSEnumTypedefine_h
#define FSNSEnumTypedefine_h

typedef NS_ENUM (NSInteger, FSGameOverAlertType){
    FSGameOverAlertTypeWin,
    FSGameOverAlertTypeDefeat,
    FSGameOverAlertTypeDraw
};

typedef NS_ENUM (NSInteger, FSGamePlayAgainType){
    FSGamePlayAgainTypePlayAgain,
    FSGamePlayAgainTypePlay
};
typedef NS_ENUM (NSInteger, FSGameSwitchType){
    FSGameSwitchTypeSwitch,
    FSGameSwitchTypeTimer
};

typedef NS_ENUM (NSInteger, FSGameOverAlertOptionType){
    FSGameOverAlertOptionTypeAgain,
    FSGameOverAlertOptionTypeSwitch,
    FSGameOverAlertOptionTypeClose
};

typedef NS_ENUM (NSInteger, FSRankType) {
    // 财富类
    FSRankTypeWealth            = 1,
    //  PK游戏 win point榜(胜点，类似胜利获取的积分)100-199 胜点类
    FSRankTypePKGameWinPoint    = 100,
    // 游戏获取财富类
    FSRankTypePKGameGain        = 200,
    // 高级(high quality)游戏收益榜
    FSRankTypeHKGameGain        = 201,
    // 高级(high quality)游戏金币收益榜
    FSRankTypeHQGameGain        = 202
};

typedef NS_ENUM (NSInteger, FSRankScope){
    FSRankScopeNone     = 0,
    FSRankScopeGlobal,
    FSRankScopeBattleField
};

typedef NS_ENUM (NSInteger, FSRankingPeriod){
    FSRankingPeriodDaily    = 1,
    FSRankingPeriodWeekly,
    FSRankingPeriodMonthly,
    FSRankingPeriodYearly
};

typedef NS_ENUM (NSInteger, FSHonorWallType){
    FSHonorWallTypeRankingDunia    = 0,
    FSHonorWallTypePeringkatDivisi,
    FSHonorWallTypeWorldRankings,
    FSHonorWallTypeCompetitionRankings
};

#define ParamClassSetParam

#endif /* FSNSEnumTypedefine_h */
