// TODO Find a way to not have to import React
import React from 'react';
import { render } from '@testing-library/react';
import { expect } from 'chai';
import App from './App';

describe('<App>', () => {
  it('renders learn react link', () => {
    const { getByText } = render(<App />);
    const linkElement = getByText(/learn react/i);
    expect(document.body.contains(linkElement));
  });

  it('test', () => {
    expect(1).equal(1);
  });
});
