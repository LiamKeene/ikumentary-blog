shared_examples_for 'Ikumentary Pages' do
  it { expect(page).to have_title(full_title(heading)) }
  it { expect(page).to have_content(content) }
end