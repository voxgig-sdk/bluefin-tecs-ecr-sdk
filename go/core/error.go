package core

type BluefinTecsEcrError struct {
	IsBluefinTecsEcrError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewBluefinTecsEcrError(code string, msg string, ctx *Context) *BluefinTecsEcrError {
	return &BluefinTecsEcrError{
		IsBluefinTecsEcrError: true,
		Sdk:              "BluefinTecsEcr",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *BluefinTecsEcrError) Error() string {
	return e.Msg
}
