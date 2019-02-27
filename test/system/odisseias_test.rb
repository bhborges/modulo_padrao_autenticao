require 'application_system_test_case'

class OdisseiasTest < ApplicationSystemTestCase
  setup do
    @odisseia = odisseias(:one)
  end

  test 'visiting the index' do
    visit odisseias_url
    assert_selector 'h1', text: 'Odisseias'
  end

  test 'creating a Odisseia' do
    visit odisseias_url
    click_on 'New Odisseia'

    fill_in 'Fonte', with: @odisseia.fonte
    fill_in 'Texto', with: @odisseia.texto
    click_on 'Create Odisseia'

    assert_text 'Odisseia was successfully created'
    click_on 'Back'
  end

  test 'updating a Odisseia' do
    visit odisseias_url
    click_on 'Edit', match: :first

    fill_in 'Fonte', with: @odisseia.fonte
    fill_in 'Texto', with: @odisseia.texto
    click_on 'Update Odisseia'

    assert_text 'Odisseia was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Odisseia' do
    visit odisseias_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Odisseia was successfully destroyed'
  end
end
