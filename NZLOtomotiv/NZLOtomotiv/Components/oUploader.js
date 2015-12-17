(function ($) {
    $.fn.oUploader = function (options) {
        if (Object.prototype.toString.call(options) == "[object String]") {
            if (options === "instance")
                return $(this).eq(0).data("oUploader");
        }
        return this.each(function (i, el) {
            //If oUploader is already initiated on element, do nothing
            if (!!$(this).data("oUploader")) {
                return console.warn("Calling oUploader() on an oUploader element will do nothing.");
            }

            //set internal variables
            var _this = $(this),
                _failed,
                _success,
                _failArguments,
                _successArguments,
                _completeArguments;

            //Set options
            var _opt = $.extend(true, {}, $.fn.oUploader.defaults, options);

            //Create and assign the instance of uOploader
            var instance = {
                options: _opt,
                destroy: function () {
                    //Destroy everything related to this oUploader instance
                    _this.children(".o-uploader-wrapper").remove();
                    _this.removeClass("o-uploader").removeData("oUploader");
                    return _this;
                },
                isEmpty: function () {
                    return !instance.input.val();
                },
                option: function (options) {
                    $.extend(true, _opt, options);
                    return instance;
                },
                getFiles: function(){
                    return instance.input.get(0).files;
                },
                input: undefined,
                info: undefined,

                _doneCB: [],
                _failCB: [],
                _alwaysCB: [],
                done: function (func) {
                    if (_success) {
                        func.apply(instance, _successArguments);
                    }
                    instance._doneCB.push(func);
                    return instance;
                },
                fail: function (func) {
                    if (_failed) {
                        func.apply(instance, _failArguments);
                    }
                    instance._failCB.push(func);
                    return instance;
                },
                always: function (func) {
                    if (_success || _failed) {
                        func.apply(instance, _completeArguments);
                    }
                    instance._alwaysCB.push(func);
                    return instance;
                },

                _paint: function () {
                    var wrap = $("<div>"),
                        btn = $("<button>"),
                        info = $("<div>"),
                        input = $("<input>");

                    wrap.addClass("o-uploader-wrapper").appendTo(_this);
                    btn.addClass("o-uploader-btn " + _opt.buttonClass).text(_opt.text).appendTo(wrap).css(_opt.buttonStyle);
                    info.addClass("o-uploader-info").appendTo(wrap);
                    input.addClass("o-uploader-input").attr({ type: "file", multiple: _opt.allowMultiple, accept: _opt.customFileTypes });
                    instance.input = input;
                    instance.info = info;
                    _opt.feedback.element = !!options.feedback && options.feedback.element ? options.feedback.element : info;

                    btn.click(function () { input.trigger("click"); });

                    input.on("change", function (e) {
                        _softReset();

                        var stop = _opt.onChange(e, this);
                        if (stop === false) { return; }

                        $.each(this.files, function (k, v) {
                            if (_failed) return false;

                            info.text(info.text() + (k > 0 ? ", " : " ") + v.name);

                            var s = parseFloat(v.size);
                            if (_opt.maxSize != undefined && (s > parseFloat(_opt.maxSize) * 1024)) {
                                _inputClear();

                                _register.failure(_opt.texts.sizeFail, _opt.texts.sizeFail);
                                _register.complete(_opt.texts.sizeFail);
                            }
                            else {
                                instance._formdata.append("file" + k, v);
                            }
                        });
                    });

                },
                _formdata: new FormData()
            }
            _this.data("oUploader", instance);


            //Put server parameters
            $.each(_opt.serverParameters, function (key, val) {
                instance._formdata.append(key, val);
            });

            //Draw the elements necessary
            instance._paint();

            //Check trigger
            //If there is a trigger, bind the upload event to it. Otherwise bind the upload to the change event of the input
            if ($(_opt.trigger).length > 0) {
                $(_opt.trigger).off(_opt.triggerEvent + ".oFileUpload").on(_opt.triggerEvent + ".oFileUpload", function () {
                    _upload();
                });
            } else if (_opt.trigger === "manual") {
                //Manual trigger
                //Do not upload files. Let the user handle the upload
                //instance.getFiles() method should be used to get the files
            }
            else {
                instance.input.on("change", function () {
                    _upload();
                });
            }

            var _inputClear = function () {
                instance.input.wrap("<form>").closest('form').get(0).reset();
                instance.input.unwrap();
                instance.info.empty();
            }
            var _softReset = function () {
                _failed = _success = false;
                _failArguments = _successArguments = _completeArguments = undefined;
                instance.info.text("");
                $(_opt.feedback.element).text("").removeClass("o-uploader-fb-success o-uploader-fb-failure");
            }
            var _upload = function () {
                //Do not upload if it failed for some reason
                if (_failed) return;

                //Throw error if no url specified for ajax
                if (!_opt.url) return console.error("You need to specify an url for the ajax upload");

                $.ajax({
                    url: _opt.url,
                    type: "post",
                    data: instance._formdata,
                    cache: false,
                    processData: false,
                    contentType: false,
                    beforeSend:
                        function (jqxhr, ajaxSettings) {
                            //Do not upload if the input is empty
                            if (instance.isEmpty()) return false;
                            return _opt.beforeSend(jqxhr, ajaxSettings);
                        },
                    success:
                        function (response, status, jqxhr) {
                            _register.success(_opt.texts.success, response, jqxhr);
                        },
                    error:
                        function (jqxhr, status, errorMessage) {
                            _register.failure(errorMessage, errorMessage, jqxhr);
                        },
                    complete:
                        function (jqxhr, status) {
                            _register.complete(jqxhr);
                        }
                });
            }
            var _feedback = function (message, type) {
                if (_opt.feedback.enabled === false) return;

                $(_opt.feedback.element).text(message).removeClass("o-uploader-fb-success o-uploader-fb-failure").addClass("o-uploader-fb-" + type);
            }
            var _register = {
                success: function (feedbackText) {
                    _feedback(feedbackText, "success");
                    _successArguments = [];
                    for (var i = 1; i < arguments.length; i++) {
                        _successArguments.push(arguments[i]);
                    }
                    _opt.onSuccess.apply(instance, _successArguments);
                    console.log(instance);
                    $.each(instance._doneCB, function (i, func) { func.apply(instance, _successArguments) });
                    _success = true;
                },
                failure: function (feedbackText) {
                    _feedback(feedbackText, "failure");
                    _failArguments = [];
                    for (var i = 1; i < arguments.length; i++) {
                        _failArguments.push(arguments[i]);
                    }
                    _opt.onFail.apply(instance, _failArguments);
                    $.each(instance._failCB, function (i, func) { func.apply(instance, _failArguments); });
                    _failed = true;
                },
                complete: function () {
                    _completeArguments = [];
                    for (var i = 0; i < arguments.length; i++) {
                        _completeArguments.push(arguments[i]);
                    }
                    _opt.onComplete.apply(instance, _completeArguments);
                    $.each(instance._alwaysCB, function (i, func) { func.apply(instance, _completeArguments) });
                }
            };
        });
    }


    $.fn.oUploader.defaults = {
        allowMultiple: false,
        url: undefined,
        serverParameters: {},
        text: "Select File...",
        buttonStyle: {},
        buttonClass: "",
        trigger: undefined,
        triggerEvent: "click",
        maxSize: undefined,
        customFileTypes: undefined,
        feedback: {
            enabled: true
        },
        texts: {
            sizeFail: "Cannot be uploaded because file size exceeds the limit.",
            success: "Files were successfully uploaded.",
            noFileSuccess: "No files selected."
        },
        onChange: function (e, input) { },
        beforeSend: function (jqxhr, ajaxSettings) { },
        onSuccess: function (response, jqxhr) { },
        onComplete: function (response, jqxhr) { },
        onFail: function (response, jqxhr) { }
    }
    $.oUploader = function (method) {
        if (method === "setDefaults") {
            $.extend(true, $.fn.oUploader.defaults, arguments[1]);

        }
    }
})(jQuery);