//
//  ViewController.swift
//  Mii
//
//  Created by yangsibai on 15/3/1.
//  Copyright (c) 2015年 massimo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var copyPushButton: NSButtonCell!
    @IBOutlet weak var minifyButton: NSButton!
    @IBOutlet weak var pasteButton: NSButton!
    @IBOutlet var originalTextView: NSTextView!
    @IBOutlet var minifiedTextView: NSTextView!
    
    @IBOutlet var al:NSAlert!
    
    private var minifierService: MinifierService!
    
    private var nsPasteBoard: NSPasteboard!

    override func viewDidLoad() {
        super.viewDidLoad()
        minifierService = MinifierService()
        nsPasteBoard = NSPasteboard.generalPasteboard()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func minify(sender: AnyObject) {
        if originalTextView.string == "" {
            al = NSAlert();
            al.informativeText = "请输入需要压缩的文本"
            al.messageText = "Error"
            al.showsHelp = false
            al.addButtonWithTitle("Ok")
            al.runModal()
        }
        else{
            //minifierService.minifyCss(originalTextView.string!, success: onMinifiedSuccess, failure: onMinifiedError)
            minifierService.minify(ContentType.CSS, content: originalTextView.string!, success: onMinifiedSuccess, failure: onMinifiedError)
        }
    }
    @IBAction func paste(sender: AnyObject) {
        originalTextView.string = nsPasteBoard.stringForType("public.utf8-plain-text")
    }
    
    @IBAction func copyResult(sender: AnyObject) {
        var str:String = String(minifiedTextView.string!)
        nsPasteBoard.clearContents()
        nsPasteBoard.writeObjects([str])
    }
    
    private func onMinifiedSuccess(result:String) -> Void{
        dispatch_async(dispatch_get_main_queue()){
            self.minifiedTextView.string = result
        }
    }
    
    private func onMinifiedError(error:NSError) -> Void{
        println(error.description)
    }
}

