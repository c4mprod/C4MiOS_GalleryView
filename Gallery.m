/*******************************************************************************
 * This file is part of the C4MiOS_GalleryView project.
 * 
 * Copyright (c) 2012 C4M PROD.
 * 
 * C4MiOS_GalleryView is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * C4MiOS_GalleryView is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with C4MiOS_GalleryView. If not, see <http://www.gnu.org/licenses/lgpl.html>.
 * 
 * Contributors:
 * C4M PROD - initial API and implementation
 ******************************************************************************/

#import "Gallery.h"


@implementation Gallery


@synthesize mTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        [self buildView];
		mTableView = [[UITableView alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
        [self buildView];
		mTableView = [[UITableView alloc] init];
    }
    return self;
}

- (void)buildView
{
    CGRect frame = self.frame;
	
	[mTableView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    mTableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
	
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.rowHeight = frame.size.width;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.bounces = YES;
    mTableView.alwaysBounceVertical = YES;
    mTableView.showsVerticalScrollIndicator = NO;
    mTableView.backgroundColor = [UIColor clearColor];
    [mTableView setContentOffset:CGPointMake(0, 1) animated:NO];
    [self addSubview:mTableView];
}

- (void)reloadData
{
	[mTableView reloadData];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	
	mTableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}


#pragma mark - Custom methods

- (void)setCellWidth:(NSInteger)width
{
    mTableView.rowHeight = width;
    [mTableView reloadData];
    [self adjustScroll:mTableView];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    mTableView.dataSource = dataSource;
    [mTableView reloadData];
    [self adjustScroll:mTableView];
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    mTableView.delegate = delegate;
    [mTableView reloadData];
    [self adjustScroll:mTableView];
}

- (void)scrollToIndex:(NSInteger)index atPosition:(UITableViewScrollPosition)position animated:(BOOL)animated
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:animated];
    [self adjustScroll:mTableView];
}

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated atPosition:(UITableViewScrollPosition)position
{
    [mTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:animated scrollPosition:position];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)adjustScroll:(UIScrollView*)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y == 0)
	{
        offset.y = 1;
    }
	else if (offset.y == scrollView.contentSize.height-scrollView.frame.size.width)
	{
        offset.y = scrollView.contentSize.height - scrollView.frame.size.width - 1;
    }
    [scrollView setContentOffset:offset animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!scrollView.dragging)
	{
        [self adjustScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self adjustScroll:scrollView];
    }
}



#pragma mark - memory

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
	[mTableView		release];
    [super			dealloc];
}

@end
