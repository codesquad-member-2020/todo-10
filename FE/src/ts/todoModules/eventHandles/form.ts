import { URL } from '../../contants/url';
import { getParentEl } from '../../utils/commonUtil';
import { httpRequest } from '../../utils/httpRequestUtil';

interface IOnClickSubmit {
    event: Event;
    parentClassName: string;
    type: string;
    cardCallback: Function;
    logCallBack: Function;
}

const option = {
    columnId: null,
    cardId: null,
    textareaValue: null,
    logId: null,
}

function onClickSubmit({ event, parentClassName, type, cardCallback, logCallBack }: IOnClickSubmit) {
    event.preventDefault();
    const target = <HTMLElement>event.target;
    const parentEl = getParentEl(target, parentClassName);
    option.columnId = parentEl.dataset.columnId || null;
    option.cardId = parentEl.dataset.cardId || null;
    option.textareaValue = target.querySelector('textarea').value;
    switchSubmitType({ event, type, cardCallback, logCallBack });
}

async function switchSubmitType({ event, type, cardCallback, logCallBack }) {
    const { columnId, cardId, textareaValue } = option
    switch (type) {
        case 'post':
            await httpRequest.post(URL.DEV.ADD_CARD_API(columnId), { content: textareaValue })
                .then((data) => {
                    cardCallback(event, data);
                    option.logId = data.content.log_id;
                });
            break;
        case 'patch':
            await httpRequest.patch(URL.DEV.UPDATE_CARD_API(columnId, cardId), { content: textareaValue })
                .then((data) => {
                    cardCallback(cardId, data);
                    option.logId = data.content.log_id;
                });
            break;
    }
    httpRequest.get(URL.DEV.LOG_API(option.logId)).then((data) => logCallBack(data));
}

export { onClickSubmit };
