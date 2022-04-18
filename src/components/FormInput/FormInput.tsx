interface IFormInput {
  type: string;
  value: string;
  name: string;
  labelText?: string;
  onChange: (e: Change) => void;
}

const FormInput = ({ type, value, name, onChange, labelText }: IFormInput) => {
  return (
    <div className='form-row'>
      <label htmlFor={name} className='form-label'>
        {labelText || name}
      </label>

      <input
        type={type}
        value={value}
        name={name}
        onChange={onChange}
        className='form-input'
      />
    </div>
  );
};

export default FormInput;
