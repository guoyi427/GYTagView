//
//  GYTagView.swift
//  GYTagViewSDK
//
//  Created by kokozu on 2017/3/7.
//  Copyright © 2017年 guoyi. All rights reserved.
//

import UIKit

public class GYTagView: UIView {
    
    
    /// 标签数组
    fileprivate var _tags:[String]
    /// 标签字体大小
    fileprivate let _tagFont = UIFont.systemFont(ofSize: 15)
    /// 保存所有标签视图
    fileprivate var _tagViews:[UIButton] = []
    /// 保存所有标签的frame
    fileprivate var _frames:[CGRect] = []
    /// tagButton index
    fileprivate let _Index_tagButton = 200
    
    public init(frame:CGRect, tags:[String]) {
        _tags = tags
        super.init(frame: frame)
        updateUI(tags: tags)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Prepare
    public func updateUI(tags:[String]) {
        //  清理
        clearTagViews()
        
        _tags = tags
        
        //  根据 _tags 计算所有frames
        _frames = calculateFrame()
        
        //  创建 tag
        for index in 0..._tags.count-1 {
            let tagButton = UIButton(type: .custom)
            var tagFrame: CGRect = CGRect()
            if _frames.count > index {
                tagFrame = _frames[index]
            }
            tagButton.frame = tagFrame
            tagButton.setTitle(_tags[index], for: .normal)
            tagButton.setTitleColor(UIColor.black, for: .normal)
            tagButton.titleLabel?.font = _tagFont
            tagButton.backgroundColor = self.backgroundColor
            tagButton.layer.borderColor = UIColor.orange.cgColor
            tagButton.layer.borderWidth = 1
            tagButton.layer.masksToBounds = true
            tagButton.layer.cornerRadius = 3
            tagButton.tag = _Index_tagButton + index
            tagButton.addTarget(self, action: #selector(tagButtonAction(button:)), for: .touchUpInside)
            self.addSubview(tagButton)
            _tagViews.append(tagButton)
        }
    }
    
    /// 清空全部标签视图
    fileprivate func clearTagViews() {
        for tagBtn in _tagViews {
            tagBtn.removeFromSuperview()
        }
        _tagViews.removeAll()
    }
    
    /// 计算frame
    ///
    /// - Returns: 返回计算好的frame
    fileprivate func calculateFrame() -> [CGRect] {
        /// max tag size
        let tagMaxSize = CGSize(width: self.frame.width, height: 20)
        /// options
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin,.usesFontLeading]
        /// attributes
        let attributes: [String: Any] = [NSFontAttributeName: _tagFont]
        
        
        /// 每个tag之间的缝隙
        /// 水平缝隙
        let padding_horizontal: CGFloat = 10
        /// 垂直缝隙
        let padding_vertical: CGFloat = 10
        
        /// 保存所有tag的frame
        var frames: [CGRect] = []
        /// 保存上一个tag的frame
        var lastTagFrame = CGRect(x: -padding_horizontal, y: 0, width: 0, height: 0)
        
        for tag in _tags {
            var tagFrame = (tag as NSString).boundingRect(with: tagMaxSize, options: options, attributes: attributes, context: nil)
            //  让标签内文字宽松10像素
            tagFrame.size.width += 10
            tagFrame.size.height += 10
            
            //  判断是否需要换行
            if self.frame.width - lastTagFrame.maxX < tagFrame.width + padding_horizontal {
                //  如果 上一个标签与右侧边框空隙 小于 当前标签的宽度 + 水平缝隙  就需要换行
                tagFrame.origin.y = lastTagFrame.maxY + padding_vertical
                tagFrame.origin.x = 0
            } else {
                //  如果不需要换行 放在上一个标签的右边
                tagFrame.origin.y = lastTagFrame.minY
                tagFrame.origin.x = lastTagFrame.maxX + padding_horizontal
            }
            //  保存上一次的frame
            lastTagFrame = tagFrame
            //  缓存frame
            frames.append(tagFrame)
        }
        
        return frames
    }
    
    //MARK: Button Action
    @objc fileprivate func tagButtonAction(button: UIButton) {
        /// button 下标
        let index = button.tag - _Index_tagButton
        /// 删除点击tag
        if _tags.count > index && _tagViews.count > index {
            _tags.remove(at: index)
            _tagViews.remove(at: index)
            button.removeFromSuperview()
        }
        
        //  更新frame
        self._frames.removeAll()
        self._frames = calculateFrame()
        
        /// 更新frame动画
        UIView.animate(withDuration: 0.25) {
            let count = self._tagViews.count - 1
            for index in 0...count {
                let tagView = self._tagViews[index]
                tagView.tag = self._Index_tagButton + index
                let frame = self._frames[index]
                tagView.frame = frame
            }
        }
    }
}
