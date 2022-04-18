import { ComponentStory } from '@storybook/react';
import FormInput from './FormInput';

export default {
  title: 'Components/FormInput',
  component: FormInput,
};

const Template: ComponentStory<typeof FormInput> = args => (
  <FormInput {...args} />
);

export const Primary = Template.bind({});
Primary.args = {
  labelText: 'Name',
  type: 'text',
  name: 'name',
};
