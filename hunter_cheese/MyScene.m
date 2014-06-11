//
//  MyScene.m
//  hunter_cheese
//
//  Created by RODRIGO GONCALVES MUNIZ on 10/06/14.
//  Copyright (c) 2014 RODRIGO GONCALVES MUNIZ. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        // Criacao do fundo de tela
        self.physicsWorld.contactDelegate = self;
        
        SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"Bg.png"];
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:background];
        
        //criar personagem rato, posicao, e corpo fisico...
        SKSpriteNode* rato = [[SKSpriteNode alloc] initWithImageNamed: @"rato.gif"];
        rato.name = ratoNome;
        rato.position = CGPointMake(rato.frame.size.width/2, (self.frame.size.height-rato.frame.size.height/2));
        [self addChild:rato];
        rato.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rato.frame.size];
        rato.physicsBody.restitution = 0.1f;
        rato.physicsBody.friction = 0.4f;
        rato.physicsBody.dynamic = NO;
        
        //criar bolinha guia - em construcao
        SKSpriteNode* bola = [[SKSpriteNode alloc] initWithImageNamed: @"ball.png"];
        bola.position = CGPointMake(rato.frame.size.width/2+bola.frame.size.width, (self.frame.size.height-rato.frame.size.height/2));
        [self addChild:bola];
        bola.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bola.frame.size];
        bola.physicsBody.restitution = 0.1f;
        bola.physicsBody.friction = 0.4f;
        bola.physicsBody.dynamic = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch* touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:touchLocation];
    if (body && [body.node.name isEqualToString: ratoNome]) {
        NSLog(@"Dedou o rato!");
        self.DedoNoRato = YES;
    }
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // 1 Check whether user tapped paddle
    
    if (self.DedoNoRato) {
        // 2 Get touch location
        UITouch* touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        CGPoint previousLocation = [touch previousLocationInNode:self];
        
        // 3 Get node for paddle
        SKSpriteNode* rato = (SKSpriteNode*)[self childNodeWithName: ratoNome];
        
        // 4 Calculate new position along x for paddle
        int ratoX = rato.position.x + (touchLocation.x - previousLocation.x);
        
        int ratoY = rato.position.y + (touchLocation.y - previousLocation.y);
        
        // 5 Limit x so that the paddle will not leave the screen to left or right
        ratoX = MAX(ratoX, rato.size.width/2);
        ratoX = MIN(ratoX, self.size.width - rato.size.width/2);
        ratoY = MAX(ratoY, rato.size.height/2);
        ratoY = MIN(ratoY, self.size.height - rato.size.height/2);
        // 6 Update position of paddle
        rato.position = CGPointMake(ratoX, ratoY);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
