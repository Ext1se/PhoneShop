String.prototype.isEmpty = function() {
    return (this.length === 0 || !this.trim());
};

String.prototype.replaceAll = function(search, replace){
    return this.split(search).join(replace);
}

function isValid(name, view) {
    let errorClass = 'is-invalid';
    if (name.isEmpty()) {
        view.addClass(errorClass);
        return false;
    } else {
        view.removeClass(errorClass);
        return true;
    }
}

function enableSpinnerButton(isEnabled, viewSpinner, viewButton) {
    let spinnerClass = 'spinner-border';
    if (!isEnabled) {
        viewButton.prop("disabled", true);
        viewSpinner.addClass(spinnerClass);
    } else {
        viewButton.prop("disabled", false);
        viewSpinner.removeClass(spinnerClass);
    }
}

function enableButton(isEnabled, viewButton) {
    if (!isEnabled) {
        viewButton.prop("disabled", true);
    } else {
        viewButton.prop("disabled", false);
    }
}

function showSpinner(isShowing, viewSpinner) {
    let spinnerClass = 'spinner-border';
    if (isShowing) {
        viewSpinner.addClass(spinnerClass);
    } else {
        viewSpinner.removeClass(spinnerClass);
    }
}