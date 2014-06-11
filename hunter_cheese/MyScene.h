//
//  MyScene.h
//  hunter_cheese
//

//  Copyright (c) 2014 RODRIGO GONCALVES MUNIZ. All rights reserved.
//

static  NSString *ratoNome = @"rato";
static  NSString *bolaNome = @"bola";

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) BOOL DedoNoRato;

@end
