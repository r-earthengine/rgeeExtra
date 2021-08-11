context("translate testing - Valeria")

ee_extra <- reticulate::import("ee_extra")
translate <- ee_extra$JavaScript$utils$translate

test_that("image overview - I", {
message <-
"
var loadedImage = ee.Image('JAXA/ALOS/AW3D30/V2_2');
var first = ee.ImageCollection('COPERNICUS/S2_SR')
                .filterBounds(ee.Geometry.Point(-70.48, 43.3631))
                .filterDate('2019-01-01', '2019-12-31')
                .sort('CLOUDY_PIXEL_PERCENTAGE')
                .first();
var uri = 'gs://gcp-public-data-landsat/LC08/01/001/002/' +
    'LC08_L1GT_001002_20160817_20170322_01_T2/' +
    'LC08_L1GT_001002_20160817_20170322_01_T2_B5.TIF';
var cloudImage = ee.Image.loadGeoTIFF(uri);
"
expect_type(translate(message), "character")
})


test_that("image overview - II", {
message <-
"
// Create a constant image.
var image1 = ee.Image(1);

// Concatenate two images into one multi-band image.
var image2 = ee.Image(2);
var image3 = ee.Image.cat([image1, image2]);

// Create a multi-band image from a list of constants.
var multiband = ee.Image([1, 2, 3]);
print(multiband);

// Select and (optionally) rename bands.
var renamed = multiband.select(
    ['constant', 'constant_1', 'constant_2'], // old names
    ['band1', 'band2', 'band3']               // new names
);

// Add bands to an image.
var image4 = image3.addBands(ee.Image(42));
"
expect_type(translate(message), "character")
})
