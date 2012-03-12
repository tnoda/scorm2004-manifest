require_relative 'helper'
require 'nokogiri'
require 'open-uri'
require 'pathname'

class MbceTest < ActiveSupport::TestCase
  test 'parsing imsmanifest.xml of ADL SCORM 2004 4th Edition MBCE' do
    manifest = Scorm2004::Manifest(xml)

    # <manifest>
    assert_equal 'LMSTestPackage_T-01b', manifest.identifier
    assert_equal '1.0', manifest.version
    
    # <resources>
    resources = manifest.resources

    # <resource>
    resource_0 = resources.resources[0]
    assert_equal 'RES-0E255857-7E71-D9B4-3AFB-3F743420BFC7', resource_0.identifier
    assert_equal 'asset', resource_0.scorm_type

    resource_1 = resources.resources[1]
    assert_equal 'RES-A5C12CB1-389E-4B4D-2420-2F194C3E51C0', resource_1.identifier
    assert_equal 'sco', resource_1.scorm_type
    assert_equal 'MBCE/01_introduction_to_manifests.html', resource_1.href
    assert_equal 1, resource_1.files.size
    assert_equal 1, resource_1.dependencies.size

    # <file>
    assert_equal 11, resource_0.files.size
    file_0 = resource_0.files[0]
    assert_equal 'Shared%20Files/scripts/APIWrapper.js', file_0.href

    # <dependency>
    dependency_0 = resource_1.dependencies[0]
    assert_equal 'RES-0E255857-7E71-D9B4-3AFB-3F743420BFC7', dependency_0.identifierref

    # <organizations>
    organizations = manifest.organizations
    assert_equal 'ORG-AAE040C6-5D31-FF80-7A74-C93346D3DE42', organizations.default
    assert_equal 1, organizations.organizations.size

    # <organization>
    organization = organizations.organizations.first
    assert_equal 'ORG-AAE040C6-5D31-FF80-7A74-C93346D3DE42', organization.identifier
    assert_equal 'SCORM 2004 4th Edition Manifest Basics Content Example 1.0', organization.title.to_s

    # <sequencing>
    sequencing = organization.sequencing
    assert_equal true, sequencing.control_mode.flow

    # <item>
    item_0 = organization.items[0]
    assert_equal 'ITEM-5C1908B3-BD20-5B1D-0586-F9B3EA30732D', item_0.identifier
    assert_equal true, item_0.isvisible
    assert_equal 'RES-A5C12CB1-389E-4B4D-2420-2F194C3E51C0', item_0.identifierref
    assert_equal 'Introduction to Manifests', item_0.title.to_s

    # <presentation>
    assert_equal 'continue', item_0.presentation.navigation_interface.hide_lmsuis[0].to_s
    assert_equal 'previous', item_0.presentation.navigation_interface.hide_lmsuis[1].to_s
  end

  private

  def xml
    open(File.exist?(path) ? path : download_manifest_file)
  end

  def path
    create_tmpdir + 'mbce.xml'
  end

  def create_tmpdir
    File.exist?(tmpdir) && File.directory?(tmpdir) ? tmpdir : Pathname(FileUtils.mkdir_p(tmpdir).first)
  end

  def tmpdir
    Pathname('../tmp')
  end

  def download_manifest_file
    File.open(path, 'wb') do |f|
      f.write open('https://raw.github.com/gist/2010363/73c72a39f253572a201a4f7670e57252e70339c3/imsmanifest.xml', proxy: ENV['http_proxy']).read
    end
    path
  end
end

