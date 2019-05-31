// Code generated by go-swagger; DO NOT EDIT.

package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	strfmt "github.com/go-openapi/strfmt"

	"github.com/go-openapi/swag"
)

// GetKeysIDTagsOKBody get keys Id tags o k body
// swagger:model getKeysIdTagsOKBody
type GetKeysIDTagsOKBody struct {

	// A collection of tags for this resource
	Tags []string `json:"tags,omitempty"`
}

// Validate validates this get keys Id tags o k body
func (m *GetKeysIDTagsOKBody) Validate(formats strfmt.Registry) error {
	return nil
}

// MarshalBinary interface implementation
func (m *GetKeysIDTagsOKBody) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *GetKeysIDTagsOKBody) UnmarshalBinary(b []byte) error {
	var res GetKeysIDTagsOKBody
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}