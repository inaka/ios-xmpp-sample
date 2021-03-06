#import "XMPPRoomLightMessageCoreDataStorageObject.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@interface XMPPRoomLightMessageCoreDataStorageObject ()

@property(nonatomic,strong) XMPPJID * primitiveRoomJID;
@property(nonatomic,strong) NSString * primitiveRoomJIDStr;

@property(nonatomic,strong) XMPPJID * primitiveJid;
@property(nonatomic,strong) NSString * primitiveJidStr;

@property(nonatomic,strong) XMPPMessage * primitiveMessage;
@property(nonatomic,strong) NSString * primitiveMessageStr;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation XMPPRoomLightMessageCoreDataStorageObject

@dynamic message;
@dynamic messageStr;

@dynamic roomJID, primitiveRoomJID;
@dynamic roomJIDStr, primitiveRoomJIDStr;

@dynamic jid, primitiveJid;
@dynamic jidStr, primitiveJidStr;

@dynamic nickname;
@dynamic body;
@dynamic localTimestamp;
@dynamic remoteTimestamp;
@dynamic isFromMe;
@dynamic fromMe;

@dynamic type;

@dynamic streamBareJidStr;

@dynamic primitiveMessage;
@dynamic primitiveMessageStr;

#pragma mark Transient roomJID

- (XMPPJID *)roomJID
{
	// Create and cache on demand
	
	[self willAccessValueForKey:@"roomJID"];
	XMPPJID *tmp = self.primitiveRoomJID;
	[self didAccessValueForKey:@"roomJID"];
	
	if (tmp == nil)
	{
		NSString *roomJIDStr = self.roomJIDStr;
		if (roomJIDStr)
		{
			tmp = [XMPPJID jidWithString:roomJIDStr];
			self.primitiveRoomJID = tmp;
		}
	}
	
	return tmp;
}

- (void)setRoomJID:(XMPPJID *)roomJID
{
	[self willChangeValueForKey:@"roomJID"];
	[self willChangeValueForKey:@"roomJIDStr"];
	
	self.primitiveRoomJID = roomJID;
	self.primitiveRoomJIDStr = [roomJID full];
	
	[self didChangeValueForKey:@"roomJID"];
	[self didChangeValueForKey:@"roomJIDStr"];
}

- (void)setRoomJIDStr:(NSString *)roomJIDStr
{
	[self willChangeValueForKey:@"roomJID"];
	[self willChangeValueForKey:@"roomJIDStr"];
	
	self.primitiveRoomJID = [XMPPJID jidWithString:roomJIDStr];
	self.primitiveRoomJIDStr = roomJIDStr;
	
	[self didChangeValueForKey:@"roomJID"];
	[self didChangeValueForKey:@"roomJIDStr"];
}

#pragma mark Transient jid

- (XMPPJID *)jid
{
	// Create and cache on demand
	
	[self willAccessValueForKey:@"jid"];
	XMPPJID *tmp = self.primitiveJid;
	[self didAccessValueForKey:@"jid"];
	
	if (tmp == nil)
	{
		NSString *jidStr = self.jidStr;
		if (jidStr)
		{
			tmp = [XMPPJID jidWithString:jidStr];
			self.primitiveJid = tmp;
		}
	}
	
	return tmp;
}

- (void)setJid:(XMPPJID *)jid
{
	[self willChangeValueForKey:@"jid"];
	[self willChangeValueForKey:@"jidStr"];
	
	self.primitiveJid = jid;
	self.primitiveJidStr = [jid full];
	
	[self didChangeValueForKey:@"jid"];
	[self didChangeValueForKey:@"jidStr"];
}

- (void)setJidStr:(NSString *)jidStr
{
	[self willChangeValueForKey:@"jid"];
	[self willChangeValueForKey:@"jidStr"];
	
	self.primitiveJid = [XMPPJID jidWithString:jidStr];
	self.primitiveJidStr = jidStr;
	
	[self didChangeValueForKey:@"jid"];
	[self didChangeValueForKey:@"jidStr"];
}

#pragma mark Scalar

- (BOOL)isFromMe
{
	return [[self fromMe] boolValue];
}

- (void)setIsFromMe:(BOOL)value
{
	self.fromMe = @(value);
}

#pragma mark - Message
- (XMPPMessage *)message
{
	// Create and cache on demand
	[self willAccessValueForKey:@"message"];
    
	XMPPMessage *message = self.primitiveMessage;
    
	[self didAccessValueForKey:@"message"];
    
	if (message == nil)
	{
		NSString *messageStr = self.messageStr;
        
		if (messageStr)
		{
			NSXMLElement *element = [[NSXMLElement alloc] initWithXMLString:messageStr error:nil];
            
			message = [XMPPMessage messageFromElement:element];
			self.primitiveMessage = message;
		}
    }
    
    return message;
}

- (void)setMessage:(XMPPMessage *)message
{
	[self willChangeValueForKey:@"message"];
	[self willChangeValueForKey:@"messageStr"];
	self.primitiveMessage = message;
	self.primitiveMessageStr = [message compactXMLString];
	[self didChangeValueForKey:@"message"];
	[self didChangeValueForKey:@"messageStr"];
}

- (void)setMessageStr:(NSString *)messageStr
{
	[self willChangeValueForKey:@"message"];
	[self willChangeValueForKey:@"messageStr"];
	
	NSXMLElement *element = [[NSXMLElement alloc] initWithXMLString:messageStr error:nil];
    
	self.primitiveMessage = [XMPPMessage messageFromElement:element];
	self.primitiveMessageStr = messageStr;
	[self didChangeValueForKey:@"message"];
	[self didChangeValueForKey:@"messageStr"];
}

@end
