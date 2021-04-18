import osxphotos
import datetime

def main():
    photosdb = osxphotos.PhotosDB()
    photos = photosdb.photos(albums=["Hafur_select"])

    # for p in photos:
    #     print(
    #         p.original_filename,
    #         p.description,
    #         p.date.strftime('%Y%m%d')
    #     )


    dest_dir = 'export/fulls'
    for p in photos:

        if p.hasadjustments:
            if '.jpg' in p.original_filename or '.jpeg' in p.original_filename:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.jpg', edited=True)
            else:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.HEIC', edited=True)
        else:
            if '.jpg' in p.original_filename or '.jpeg' in p.original_filename:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.jpg')
            else:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.HEIC')


if __name__ == "__main__":
    main()
